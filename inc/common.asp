<SCRIPT LANGUAGE=vbscript RUNAT=Server>
//new funtcions

Function CreateGUID(tmpLength)
  Randomize Timer
  Dim tmpCounter,tmpGUID
  Const strValid = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  For tmpCounter = 1 To tmpLength
    tmpGUID = tmpGUID & Mid(strValid, Int(Rnd(1) * Len(strValid)) + 1, 1)
  Next
  CreateGUID = tmpGUID
End Function

function login(user,pwd)

	prmUserName = user
	prmPassword = UCase(pwd)
//	prmLang = Request.QueryString("l")
	prmIp = Request.ServerVariables("REMOTE_ADDR")
	prmIdBook = 1

	Dim http, url, formData, ndResponse
	url = "http://10.1.1.4:8000/proxyplayer.asmx/Login"

//	CreateObject("Microsoft.XMLHTTP")
	Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
	http.open "POST", url, false
//	betservice
	formData = "prmUserName=" & prmUserName
	formData = formData & "&prmPassword=" & prmPassword
	formData = formData & "&prmIp=" & prmIp
	formData = formData & "&prmIdBook=" & prmIdBook

//	http.setRequestHeader "CharSet", "UTF-8"
	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)
//	http.setRequestHeader "lastCached", now()
	http.send formData
	ndResponse = http.responseText
	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")

	Dim ndXML
	Dim isValid
	Set ndXML = CreateObject("Microsoft.XmlDom")
	isValid = ndXML.loadXML(ndResponse)
	
//	response.write ndResponse&"<br><br>"

	if isValid then
		Dim nodeList,errcode, errmsg, playerid, currencyid, x, objEvent

		set x = ndXML.getElementsByTagName("xml")
//		response.write x.length
		for each objEvent in x
			errcode = objEvent.getAttribute("ErrorCode")
			errmsg = objEvent.getAttribute("ErrorMsg")
			playerid = objEvent.getAttribute("IdPlayer") 
			currencyid = objEvent.getAttribute("Currency") 
			profileid = objEvent.getAttribute("IdProfile")
			linetypeid = objEvent.getAttribute("IdLineType")
			linestyle = objEvent.getAttribute("LineStyle")
			language = objEvent.getAttribute("IdLanguage")
			callid = objEvent.getAttribute("IdCall")
		next
	end if

	if (Not isValid) then 
		response.write "<p>There was an error processing your account.<br>Please contact Customer Service.</p>"
	else
		if errcode = 0 then
			Session("pid") = playerid
			Session("pwd") = UCase(pwd)
			Session("aid") = prmUserName
			Session("p") = prmPassword
			Session("cid") = currencyid
			Session("idprofile") = profileid
			Session("idlinetype") = linetypeid
			Session("idlinestyle") = linestyle
			Session("idlanguage") = language
			Session("idcall") = callid
			if prmLang = "ES" then
				response.redirect ("es/index.asp")
			else
				response.redirect ("index.asp")
			end if
		else
			response.write errmsg
		end if
	end if

end function

function getPlayer (pid)

	player = ""
	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "SELECT Player FROM PLAYER WHERE IdPlayer = "&pid
	recs.Open sqlStr, c
		
	IF NOT recs.EOF THEN
		player = recs("Player")
	END IF
	
	recs.Close
	Set recs = Nothing
	
	getPlayer = player
	
end function

function getGames ()

	pitcher = 0
	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "SELECT FixtureID, VisitorTeam, HomeTeam, FixtureDateTime FROM DBA_LSportsEvent "&_
		"WHERE [FixtureDateTime] > getdate() AND LeagueID = 183 order by [FixtureDateTime]"
	recs.Open sqlStr, c
		
	WHILE NOT recs.EOF
		vTeam = recs("VisitorTeam")
		hTeam = recs("HomeTeam")
		eventDT = recs("FixtureDateTime")
		teams = split(eventName," - ")
		response.write "<div class='event-sidebar mb-2' onclick='loadGame("&recs("FixtureID")&")'>"
		response.write "<span class='events-title'>MLB</span>"
		response.write "<span class='participant'>"&vTeam&"</span>"
		response.write "<span class='participant'>"&hTeam&"</span>"
		response.write "<span class='info'>"&eventDT&"</span></span></div>"
		recs.MoveNext
	WEND
	
	recs.Close
	Set recs = Nothing
	
	getPlayerPitcher = pitcher
	
end function

function getFixtureID(eventID)

	fixtureID = 0
	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "SELECT FixtureID FROM DBA_StatScore_Game WHERE game_id = " & eventID
	recs.Open sqlStr, c
		
	IF NOT recs.EOF THEN
		fixtureID = recs("FixtureID")
	END IF
	
	recs.Close
	Set recs = Nothing

	getFixtureID = fixtureID
	
end function

function getGamesLines(eventID)

	Dim game(12)
	fixtureID = getFixtureID(eventID)

	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "Execute DBA_LSports_GetLine_ByGame " & fixtureID
	recs.Open sqlStr, c
		
	IF NOT recs.EOF THEN
		game(0) = recs("VisitorRotation")
		game(1) = recs("VisitorTeam")
		game(2) = recs("HomeRotation")
		game(3) = recs("HomeTeam")
		game(4) = recs("HomeSpread")
		game(5) = recs("HomeSpreadOdds")
		game(6) = recs("VisitorSpread")
		game(7) = recs("VisitorSpreadOdds")
		game(8) = recs("HomeML")
		game(9) = recs("VisitorML")
		game(10) = recs("Total")
		game(11) = recs("TotalOver")
		game(12) = recs("TotalUnder")
	END IF
	
	recs.Close
	Set recs = Nothing

	getGamesLines = game

end function

function getProps(fixtureID)

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "SELECT MarketID, MarketName FROM [DGSData].[dbo].[DBA_LSportsLine_STG] "&_
		"WHERE FixtureID = "&fixtureID&" GROUP BY MarketID, MarketName"
	'response.write sqlStr
	rs.Open sqlStr, c
	
	WHILE NOT rs.EOF
		marketID = rs("MarketID")
		market = rs("MarketName")
		
		response.write "<div class='accordion-item'><h2 class='accordion-header' id='head_"&marketID&"'>"
		response.write "<button class='accordion-button' type='button' data-bs-toggle='collapse' data-bs-target='#d_"&marketID&"' "
		response.write "aria-expanded='true' aria-controls='collapseOne' onClick='getPropsLines("&fixtureID&","&marketID&")'>"
		response.write market&"</button></h2>"
		response.write "<div id='d_"&marketID&"' class='accordion-collapse collapse' aria-labelledby='head_"&marketID&"' data-bs-parent='#accordionExample'>"
		response.write "<div class='accordion-body'><div id='p_"&fixtureID&"_"&marketID&"'>Loading</div></div>"
		response.write "</div></div>"
		rs.MoveNext
	WEND

	rs.Close
	Set rs = Nothing
	
end function

function getPropsLines(fixtureID,marketID)

	marketType = getMarketType(marketID)
	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE DBA_LSports_PreMatch_Props @fitureID = "&fixtureID&", @marketID = "&marketID
	'response.write sqlStr
	rs.Open sqlStr, c
	
	if marketType = "TT" then
		response.write "<div class='card'>"
		response.write "<div class='card-body border p-1'>"
		response.write "<div class='row mb-1'>"
		response.write "<div class='col-4'> </div>"
		response.write "<div class='col-4 text-center'> Over</div>"
		response.write "<div class='col-4 text-center'> Under</div></div>"
	end if
	
	if marketType = "PP" then
		response.write "<div class='card'>"
		response.write "<div class='card-body border p-1'>"
		response.write "<div class='row mb-1'>"
		response.write "<div class='col-4 text-center'> Player </div>"
		response.write "<div class='col-4'>&nbsp;</div>"
		response.write "<div class='col-4 text-center'> Odds</div></div>"
	end if
	
	if marketType = "GS" then
		response.write "<div class='card'>"
		response.write "<div class='card-body border p-1'>"
		response.write "<div class='row mb-1'>"
		response.write "<div class='col-4 text-center'> Score </div>"
		response.write "<div class='col-4'>&nbsp;</div>"
		response.write "<div class='col-4 text-center'> Odds</div></div>"
	end if
	
	if marketType = "ML" then
		response.write "<div class='card'>"
		response.write "<div class='card-body border p-1'>"
		response.write "<div class='row mb-1'>"
		response.write "<div class='col-4 text-center'>&nbsp;</div>"
		response.write "<div class='col-4'>&nbsp;</div>"
		response.write "<div class='col-4 text-center'> Odds</div></div>"
	end if
	
	WHILE NOT rs.EOF
		if marketType = "TT" then
			line = rs("Line")
			over = rs("TotalOver")
			under = rs("TotalUnder")
			response.write "<div class='row mb-1'>"
			response.write "<div class='col-4 teamName text-center'>"&line&"</div>"
			response.write "<div class='col-4'><a class='btn btn-light btn-block' href='#'>"&over&"</a></div>"
			response.write "<div class='col-4'><a class='btn btn-light btn-block' href='#'>"&under&"</a></div></div>"
		end if
		if marketType = "PP" then
			player = rs("Player")
			line = rs("Line")
			odds = rs("Odds")
			response.write "<div class='row mb-1'>"
			response.write "<div class='col-4 teamName text-center'>"&player&"</div>"
			response.write "<div class='col-4'>&nbsp;</div>"
			response.write "<div class='col-4'><a class='btn btn-light btn-block' href='#'>"&odds&"</a></div></div>"
		end if
		if marketType = "GS" then
			score = rs("Score")
			line = rs("Line")
			odds = rs("Odds")
			response.write "<div class='row mb-1'>"
			response.write "<div class='col-4 teamName text-center'>"&score&"</div>"
			response.write "<div class='col-4'>&nbsp;</div>"
			response.write "<div class='col-4'><a class='btn btn-light btn-block' href='#'>"&odds&"</a></div></div>"
		end if
		if marketType = "ML" then
			team = rs("Team")
			odds = rs("Odds")
			response.write "<div class='row mb-1'>"
			response.write "<div class='col-4 teamName text-center'>"&team&"</div>"
			response.write "<div class='col-4'>&nbsp;</div>"
			response.write "<div class='col-4'><a class='btn btn-light btn-block' href='#'>"&odds&"</a></div></div>"
		end if
		rs.MoveNext
	WEND
	
	response.write "</div></div>"

	rs.Close
	Set rs = Nothing
	
end function

function getMarketType(marketID)

	marketType = ""
	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "SELECT MarketType FROM DBA_LSportsMarket WHERE MarketID = " & marketID
	recs.Open sqlStr, c
		
	IF NOT recs.EOF THEN
		marketType = recs("MarketType")
	END IF
	
	recs.Close
	Set recs = Nothing

	getMarketType = marketType
	
end function

function GetActiveLeaguesAccordion(profileID,linetypeID,LanguageID,PlayerID)

	Dim http, url, formData, ndResponse
//	url = Application("DGSproxy")&"/proxywager.asmx/GetActiveLeagues"
	url = "http://10.1.1.4:8000//proxywager.asmx/GetActiveLeagues"
	Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
	http.open "POST", url, false

	formData = "IdBook=1"
	formData = formData & "&IdProfile="&profileID
	formData = formData & "&IdLineType="&linetypeID
	formData = formData & "&WagerType=0"
	formData = formData & "&Language="&LanguageID

	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)

	http.send formData
	ndResponse = http.responseText
	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")

	Dim ndXML
	Dim isValid
	Set ndXML = CreateObject("Microsoft.XmlDom")
	isValid = ndXML.loadXML(ndResponse)
	
	if isValid then
		set x = ndXML.getElementsByTagName("index")

       
		response.write "<dl class='accordion' data-accordion>"
		for each objEvent in x
			sport = objEvent.getAttribute("value")
			sport = Replace(sport,"_"," ")
			sport = LTrim(sport)
			sport = RTrim(sport)
			sportID = Replace(sport," ","-")
			sportID = Replace(sportID,"/","-")
			response.write "<dd><a href='#"&sportID&"'><i class='fi-play size-16'></i> "&sport&"</a>"
			response.write "<div id='"&sportID&"' class='content'>"

			set detail = objEvent.getElementsByTagName("league")
			for each objDetail in detail
				idl = objDetail.getAttribute("id")
				ids = objDetail.getAttribute("idsport")
				response.write "<a href='javascript:;'>"&objDetail.getAttribute("desc")&"</a><br/>"
			next
			response.write "</div></dd>"
		next
		response.write "</dl>"

	else
		response.write "<p>There was an error processing your account.<br>Please contact Customer Service.</p>"
	end if	

end function

// end new functions

function getSports()

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE Sport_GetList"
	rs.Open sqlStr, c
	
	response.write "<ul>"&vbcr
	response.write "<li>HOME</li>"&vbcr
	WHILE NOT rs.EOF
		response.write "<li><a href='#' onclick='getLeagues("""&Trim(rs("IdSport"))&""")'>"&rs("SportName")&"</a></li>"&vbcr
		rs.MoveNext
	WEND
	response.write "</ul>"&vbcr
	rs.Close
	Set rs = Nothing

end function

function getLeagues(ids,pid)

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE GetLeaguesBySport @prmIdSport = '"&ids&"'"
	rs.Open sqlStr, c

	response.write "<div id='container'>"

	WHILE NOT rs.EOF
		getSchedule pid,rs("IdLeague"),ids,rs("Description")
//		response.write "<p>"&rs("IdLeague")&"-"&rs("Description")&"</p>"&vbcr
		rs.MoveNext
	WEND

	response.write "</div>"

	rs.Close
	Set rs = Nothing

end function


function getSchedule(idp,idc,ProfileID,ProfileLimitsID,LineTypeID,NHLLine,MLBLine,LineStyle,strLeagues,Language,utcID,AgentID,BookID)

//	response.write strLeagues
	WagerType = 0
	WagerTypeID = 0
	symbol = ""
	if LineStyle = "D" then
		symbol = "+"
	end if

//	url = Application("DGSproxy")&"/proxywager.asmx/GetScheduleUTC"
	url = "http://10.1.1.4:8000/proxywager.asmx/GetScheduleUTC"
	Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
	http.open "POST", url, false

//	formData = "IdBook=" & Application("BookID")
	formData = "IdBook="& BookID
	formData = formData & "&IdProfile=" & ProfileID
	formData = formData & "&IdProfileLimits=" & ProfileLimitsID
	formData = formData & "&IdLineType=" & LineTypeID
	formData = formData & "&NHLLine=" & NHLLine
	formData = formData & "&MLBLine=" & MLBLine
	formData = formData & "&LineStyle=" & LineStyle
	formData = formData & "&WagerType=" & WagerType
	formData = formData & "&StrIdLeagues=" & strLeagues
	formData = formData & "&IdWagerType=" & WagerTypeID
	formData = formData & "&Language=" & Language
	formData = formData & "&UTC=" & utcID
	formData = formData & "&IdAgent=" & AgentID

	http.setRequestHeader "CharSet", "UTF-8"
	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)
	http.setRequestHeader "lastCached", now()
	http.send formData
	ndResponse = http.responseText

	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")

	Dim ndXML
	Dim isValid
	Set ndXML = CreateObject("Microsoft.XmlDom")
	isValid = ndXML.loadXML(ndResponse)

	if isValid then
		set x = ndXML.getElementsByTagName("xml")

		for each objEvent in x
			errcode = objEvent.getAttribute("ErrorCode")
			errmsg = objEvent.getAttribute("ErrorMsg")
			TimeStamp = objEvent.getAttribute("TimeStamp")  
		next
	end if

	if (Not isValid) then 
		response.write "<p>There was an error processing your Request.</p>"
	else
		if errcode = 0 then
			set leagues = ndXML.getElementsByTagName("league")

			for index = 0 to leagues.Length-1
				sports = true
				
				if leagues(index).getAttribute("IdSport") = "TNT" then
					response.write "<div class='betting-lines-header'>"
					response.write "<div class='betting-lines-header-rot betting-lines-header-right-border'>ROT</div>"
					response.write "<div class='betting-lines-header-team betting-lines-header-right-border'>TEAM</div>"
					response.write "<div class='betting-lines-header-line betting-lines-header-right-border'></div>"
					response.write "<div class='betting-lines-header-line betting-lines-header-right-border'></div>"
					response.write "<div class='betting-lines-header-line'>Odds</div>"
					response.write "</div>"
				elseif leagues(index).getAttribute("IdSport") = "PROP" then
					response.write "<div class='betting-lines-header'>"
					response.write "<div class='betting-lines-header-datetime-prop betting-lines-header-right-border'>CUTOFF</div>"
					response.write "<div class='betting-lines-header-rot-prop betting-lines-header-right-border'>ROT</div>"
					response.write "<div class='betting-lines-header-team-prop betting-lines-header-right-border'>TEAM</div>"
					response.write "<div class='betting-lines-header-line-prop'>Odds</div>"
					response.write "</div>"	
				else
					response.write "<div class='betting-lines-header'>"
					response.write "<div class='betting-lines-header-datetime betting-lines-header-right-border hidden-xs'>DATE/TIME</div>"
					response.write "<div class='betting-lines-header-rot betting-lines-header-right-border'>ROT</div>"
					response.write "<div class='betting-lines-header-team betting-lines-header-right-border'>TEAM</div>"
					response.write "<div class='betting-lines-header-line betting-lines-header-right-border'>SPREAD</div>"
					response.write "<div class='betting-lines-header-line betting-lines-header-right-border'>TOTAL</div>"
					response.write "<div class='betting-lines-header-line'>ML</div>"
					response.write "</div>"	
				end if
				
				response.write "<div class='banner-title'>"&leagues(index).getAttribute("Description")&"</div>"

				for z = 0 to leagues(index).childNodes.length-1
					
					nodeName = leagues(index).childNodes(z).nodeName
					
					if nodeName = "banner" then
						response.write "<div class='banner-title banner-margin' style='overflow:auto;'>"&leagues(index).childNodes(z).getAttribute("vtm")&"<br>"&leagues(index).childNodes(z).getAttribute("htm")&"</div>"
					else
						set game = leagues(index).childNodes(z)
						gamedesc = game.getAttribute("gdesc")
						gameid = game.getAttribute("idgm")
						idgametype = game.getAttribute("idgmtyp")
						sportid = game.getAttribute("idspt")
						leagueid = game.getAttribute("idlg")
						gamedate = game.getAttribute("gmdt")
						dametime = game.getAttribute("gmtm")
						visitorNum = game.getAttribute("vnum")
						visitorName = game.getAttribute("vtm")
						visitorPitcher = game.getAttribute("vpt")
						homeNum = game.getAttribute("hnum")
						homeName = game.getAttribute("htm")
						homePitcher = game.getAttribute("hpt")
						
						strday = Right(gamedate,2)
						strmonth = Mid(gamedate,5,2)
						stryear = Left(gamedate,4)
						strDate = strmonth&"/"&strday&"/"&stryear
						strFullDate = strDate&" "&dametime
						
						//if gamedate = "20151101" then
							//strFullDate = DateAdd("h",-1,strFullDate)
						//end if 
						
						linkVisitorTeam = Replace(visitorName,"'","-")
						linkHomeTeam = Replace(homeName,"'","-")
						
						if gamedesc <> "" then
							response.write "<h6>"&gamedesc&"</h6>"
						end if

						if sportid = "TNT" or sportid = "PROP" then
							if homeName <> "" then
								response.write "<div class='banner-title banner-margin' style='overflow:auto;'>"&homeName&"</div>"
							end if
							if sportid = "TNT" then
								response.write "<h6>Wager Cutoff: "&strFullDate&"</h6>"
							end if							
						end if											

						set lines = leagues(index).childNodes(z).getElementsByTagName("line")
						
						doregular = false
						
						for each line in lines

							if sportid = "TNT" then
								rot = line.getAttribute("tmnum")
								team = line.getAttribute("tmname")
								odds = line.getAttribute("odds")
								showOdds = line.getAttribute("oddsh")
								linkTeam = Replace(team,"'","-")
								response.write "<div class='betting-lines-container tnt'>"&vbcr
								response.write "<div class='betting-lines-line-container-tnt'>"&vbcr
								response.write "<div class='betting-lines-line'>"&vbcr
								response.write "<div class='betting-lines-line-rot'>"&rot&"</div>"&vbcr
								response.write "<div class='betting-lines-line-name'><span class='visitor'>"&team&"</span></div>"&vbcr
								response.write "<div class='betting-lines-line-line'></div>"&vbcr
								response.write "<div class='betting-lines-line-line-ml'></div>"
								response.write "<div class='betting-lines-line-line' id='"&gameid&"_"&rot&"_ML'"
								response.write " onclick=""addbet('"&rot&"','"&gameid&"','ML','"&linkTeam&"','0','"&odds&"','"&sportid&"','"&leagueid&"','"&rot&"');"">"
								response.write "<a href='javascript:void(0)' class='regular-line'>"&symbol&Trim(showOdds)&"</a>"
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr															
							elseif sportid = "PROP" then
								rot = line.getAttribute("tmnum")
								team = visitorName&" "&homeName
								odds = line.getAttribute("odds")
								showOdds = line.getAttribute("oddsh")
								response.write "<div class='betting-lines-container tnt'>"&vbcr
								response.write "<div class='betting-lines-line-container-tnt'>"&vbcr
								response.write "<div class='betting-lines-line'>"&vbcr
								response.write "<div class='betting-lines-line-date-prop'>"&strFullDate&"</div>"&vbcr
								response.write "<div class='betting-lines-line-rot-prop'>"&homeNum&"</div>"&vbcr
								response.write "<div class='betting-lines-line-name-prop'><span class='visitor'>"&team&"</span></div>"&vbcr
								response.write "<div class='betting-lines-line-line-ml'"
								response.write " onclick=""addbet('"&homeNum&"','"&gameid&"','ML','"&team&"','0','"&odds&"','"&sportid&"','"&leagueid&"','"&homeNum&"');"">"
								response.write "<a href='javascript:void(0)' class='regular-line'>"&symbol&Trim(showOdds)&"</a>"
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr							
							else
								doregular = true
								visitorML = line.getAttribute("voddst")
								visitorSpread = line.getAttribute("vsprdt")
								visitorSpreadOdds = line.getAttribute("vsprdoddst")
								visitorSpecialSpread = line.getAttribute("vspt")
								visitorSpecialSpreadOdds = line.getAttribute("vspoddst")
								overTotal = Replace(line.getAttribute("ovt"),"-","")
								overTotalOdds = line.getAttribute("ovoddst")
								homeML = line.getAttribute("hoddst")
								homeSpread = line.getAttribute("hsprdt")
								homeSpreadOdds = line.getAttribute("hsprdoddst")
								homeSpecialSpread = line.getAttribute("hspt")
								homeSpecialSpreadOdds = line.getAttribute("hspoddst")
								underTotal = line.getAttribute("unt")
								underTotalOdds = line.getAttribute("unoddst")
								showVisitorSpread = line.getAttribute("vsprdh")
								showVisitorSpecialSpread = line.getAttribute("vsph")
								showHomeSpread = line.getAttribute("hsprdh")
								showHomeSpecialSpread = line.getAttribute("hsph")
								showVisitorML = line.getAttribute("voddsh")
								showHomeML = line.getAttribute("hoddsh")
								showTotalOver = line.getAttribute("ovh")
								showTotalUnder = line.getAttribute("unh")
							end if
						next

						if doregular then

							showVisitorSpread = Replace(showVisitorSpread,"&amp;frac12;","&frac12; ")
							showVisitorSpread = Replace(showVisitorSpread,"&amp;frac14;",".25 ")
							showVisitorSpread = Replace(showVisitorSpread,"&amp;frac34;",".75 ")
							showVisitorSpread = Replace(showVisitorSpread,"&amp;nbsp;&lt;SUP&gt;"," ")
							showVisitorSpread = Replace(showVisitorSpread,"&lt;/SUP&gt;","")
							showVisitorSpread = Replace(showVisitorSpread,"&lt;SUB&gt;","")
							showVisitorSpread = Replace(showVisitorSpread,"&lt;/SUB&gt;","")
							showVisitorSpread = Replace(showVisitorSpread,"+.25","+0.25")
							showVisitorSpread = Replace(showVisitorSpread,"-.25","-0.25")
							if LineStyle = "D" then
								showVisitorSpread = Replace(showVisitorSpread,"  "," ")
								showVisitorSpread = Replace(showVisitorSpread," "," +")
							end if
							showVisitorSpecialSpread = Replace(showVisitorSpecialSpread,"&amp;frac12;","&frac12; ")
							showVisitorSpecialSpread = Replace(showVisitorSpecialSpread,"&amp;nbsp;&lt;SUP&gt;"," ")
							showVisitorSpecialSpread = Replace(showVisitorSpecialSpread,"&lt;/SUP&gt;","")
							showVisitorSpecialSpread = Replace(showVisitorSpecialSpread,"&lt;SUB&gt;","")
							showVisitorSpecialSpread = Replace(showVisitorSpecialSpread,"&lt;/SUB&gt;","")
							
							showHomeSpread = Replace(showHomeSpread,"&amp;frac12;","&frac12; ")
							showHomeSpread = Replace(showHomeSpread,"&amp;frac14;",".25 ")
							showHomeSpread = Replace(showHomeSpread,"&amp;frac34;",".75 ")
							showHomeSpread = Replace(showHomeSpread,"&amp;nbsp;&lt;SUP&gt;"," ")
							showHomeSpread = Replace(showHomeSpread,"&lt;/SUP&gt;","")
							showHomeSpread = Replace(showHomeSpread,"&lt;SUB&gt;","")
							showHomeSpread = Replace(showHomeSpread,"&lt;/SUB&gt;","")
							showHomeSpread = Replace(showHomeSpread,"+.25","+0.25")
							showHomeSpread = Replace(showHomeSpread,"-.25","-0.25")
							if LineStyle = "D" then
								showHomeSpread = Replace(showHomeSpread,"  "," ")
								showHomeSpread = Replace(showHomeSpread," "," +")
							end if
							showHomeSpecialSpread = Replace(showHomeSpecialSpread,"&amp;frac12;","&frac12; ")
							showHomeSpecialSpread = Replace(showHomeSpecialSpread,"&amp;nbsp;&lt;SUP&gt;"," ")
							showHomeSpecialSpread = Replace(showHomeSpecialSpread,"&lt;/SUP&gt;","")
							showHomeSpecialSpread = Replace(showHomeSpecialSpread,"&lt;SUB&gt;","")
							showHomeSpecialSpread = Replace(showHomeSpecialSpread,"&lt;/SUB&gt;","")
							
							showVisitorML = Replace(showVisitorML,"&amp;nbsp;&lt;SUP&gt;"," ")
							showVisitorML = Replace(showVisitorML,"&lt;/SUP&gt;","")
							showVisitorML = Replace(showVisitorML,"&lt;SUB&gt;","")
							showVisitorML = Replace(showVisitorML,"&lt;/SUB&gt;","")
							
							showHomeML = Replace(showHomeML,"&amp;nbsp;&lt;SUP&gt;"," ")
							showHomeML = Replace(showHomeML,"&lt;/SUP&gt;","")
							showHomeML = Replace(showHomeML,"&lt;SUB&gt;","")
							showHomeML = Replace(showHomeML,"&lt;/SUB&gt;","")
							
							showTotalOver = Replace(showTotalOver,"&amp;frac12;","&frac12;")
							showTotalOver = Replace(showTotalOver,"&amp;frac14;",".25 ")
							showTotalOver = Replace(showTotalOver,"&amp;frac34;",".75 ")
							showTotalOver = Replace(showTotalOver,"&amp;nbsp;&lt;SUP&gt;"," ")
							showTotalOver = Replace(showTotalOver,"&lt;/SUP&gt;","")
							showTotalOver = Replace(showTotalOver,"&lt;SUB&gt;","")
							showTotalOver = Replace(showTotalOver,"&lt;/SUB&gt;","")
							showTotalOver = Replace(showTotalOver,"o","")
							showTotalOver = Replace(showTotalOver,"u","")
							if LineStyle = "D" then
								showTotalOver = Replace(showTotalOver,"  "," ")
								showTotalOver = Replace(showTotalOver," "," +")
							end if
							
							showTotalUnder = Replace(showTotalUnder,"&amp;frac12;","&frac12;")
							showTotalUnder = Replace(showTotalUnder,"&amp;frac14;",".25 ")
							showTotalUnder = Replace(showTotalUnder,"&amp;frac34;",".75 ")
							showTotalUnder = Replace(showTotalUnder,"&amp;nbsp;&lt;SUP&gt;"," ")
							showTotalUnder = Replace(showTotalUnder,"&lt;/SUP&gt;","")
							showTotalUnder = Replace(showTotalUnder,"&lt;SUB&gt;","")
							showTotalUnder = Replace(showTotalUnder,"&lt;/SUB&gt;","")
							showTotalUnder = Replace(showTotalUnder,"o","")
							showTotalUnder = Replace(showTotalUnder,"u","")
							if LineStyle = "D" then
								showTotalUnder = Replace(showTotalUnder,"  "," ")
								showTotalUnder = Replace(showTotalUnder," "," +")
							end if
		
							linkspreadclass = "regular-line"
							linkmlclass = "regular-line"
							linktotalclass = "regular-line"

							spread = visitorSpread&" "&visitorSpreadOdds&" "&homeSpread&" "&homeSpreadOdds
							ml = visitorML&" "&homeML
							total = overTotal&" "&overTotalOdds&" "&underTotal&" "&underTotalOdds
							
							if Session(gameid) = "" then
								Session(gameid) = spread&","&ml&","&total
							else
								gameline = split(Session(gameid),",")
								
								if StrComp(gameline(0),spread) <> 0 then
									linkspreadclass = "change-line"
								end if
								if StrComp(gameline(1),ml) <> 0 then
									linkmlclass = "change-line"
								end if
								if StrComp(gameline(2),total) <> 0 then
									linktotalclass = "change-line"
								end if								
								
								Session(gameid) = spread&","&ml&","&total
							end if
							
							if sportid = "SOC" then
								response.write "<div class='betting-lines-container soccer'>"&vbcr
								
								spV = split(showVisitorSpread," ")
								spH = split(showHomeSpread," ")
								ttO = split(showTotalOver," ")
								ttU = split(showTotalUnder," ")
//								response.write sp(0)
								signV = ""
								signH = ""
								//SIDE ADJUST
								if showVisitorSpread <> "" then
									if InStrRev(spV(0),".25") > 0 then
//										response.write Sgn(spV(0))
										if Sgn(spV(0)) = -1 then
											signV = "-"
											signH = "+"
										else 
											signV = "+"
											signH = "-"										
										end if
										l = Fix(spV(0))
										response.write l
										if l = 0 then
											showVisitorSpread = "pk and "&signV&"&frac12; "&spV(1)
											showHomeSpread = "pk and "&signH&"&frac12; "&spH(1)
										elseif l < 0 then
											showVisitorSpread = l&" and "&l&"&frac12; "&spV(1)
											showHomeSpread = "+"&l*-1&" and +"&l*-1&"&frac12; "&spH(1)
										elseif l > 0 then
											showVisitorSpread = "+"&l&" and +"&l&"&frac12; "&spV(1)
											showHomeSpread = l*-1&" and "&l*-1&"&frac12; "&spH(1)
										end if
									elseif InStrRev(spV(0),".75") > 0 then
										if Sgn(spV(0)) = -1 then
											signV = "-"
											signH = "+"
										else 
											signV = "+"
											signH = "-"										
										end if
										l = Fix(spV(0))
										if l = 0 then
											showVisitorSpread = signV&"&frac12; and "&(l+1)&" "&spV(1)
											showHomeSpread = signH&"&frac12; and "&(l+1)&" "&spH(1)
										elseif l < 0 then
											showVisitorSpread = l&"&frac12; and -"&((l*-1)+1)&""&spV(1)
											showHomeSpread = "+"&l*-1&"&frac12; and +"&((l*-1)+1)&" "&spH(1)
										elseif l > 0 then
											showVisitorSpread = "+"&l&"&frac12; and +"&(l+1)&" "&spV(1)
											showHomeSpread = l*-1&"&frac12; and -"&(l+1)&" "&spH(1)
										end if
	//									response.write Fix(sp(0))
									end if
								end if
								//TOTAL ADJUST
								if showTotalOver <> "" then
									
									if InStrRev(ttO(0),".25") > 0 then
										l = Fix(ttO(0))
										showTotalOver = l&" and "&l&"&frac12; "&ttO(1)
										showTotalUnder = l&" and "&l&"&frac12; "&ttU(1)
									elseif InStrRev(ttU(0),".75") > 0 then
										l = Fix(ttU(0))
										showTotalOver = l&"&frac12; and "&l+1&" "&ttO(1)
										showTotalUnder = l&"&frac12; and "&l+1&" "&ttU(1)
									end if
								end if
								
							elseif sportid = "MLB" then
								response.write "<div class='betting-lines-container baseball'>"&vbcr
								pitcherChange = getPitcherChange (gameid)
//								response.write pitcherChange
							else
								response.write "<div class='betting-lines-container regular'>"&vbcr
							end if

							response.write "<div class='betting-lines-datetime "
							if idgametype = 10 then
								response.write "circled"
							end if

							response.write " hidden-xs'>"&FormatDateTime(strFullDate,2)&"<br>"&FormatDateTime(strFullDate,3)&"</div>"&vbcr
							
							response.write "<div class='betting-lines-line-container'>"

							response.write "<div class='betting-lines-line betting-lines-line-bottom odd'>"&vbcr
							response.write "<div class='betting-lines-line-rot'>"&visitorNum&"</div>"&vbcr
							response.write "<div class='betting-lines-line-name'><span class='visitor'>"&visitorName&"</span> <span class='classpitcher"
							if pitcherChange = 1 or pitcherChange = 3 then							
								response.write " pitcherchange"
							end if
							response.write "'>"&visitorPitcher&"</span></div>"&vbcr
							response.write "<div class='betting-lines-line-line' id='"&gameid&"_0_S'"
							if Trim(sportid) = "NHL" and NHLLine = "C" then
								if visitorSpecialSpread <> "" then
									response.write " onclick=""addbet('0','"&gameid&"','S','"&linkVisitorTeam&"','"&visitorSpecialSpread&"','"&visitorSpecialSpreadOdds&"','"&sportid&"','"&leagueid&"','"&visitorNum&"');"">"
									response.write "<a href='javascript:void(0)' class='"&linkspreadclass&"'>"&showVisitorSpecialSpread&"</a>"&vbcr
								else 
									response.write ">&nbsp;"
								end if
							else
								if visitorSpread <> "" then
									response.write " onclick=""addbet('0','"&gameid&"','S','"&linkVisitorTeam&"','"&visitorSpread&"','"&visitorSpreadOdds&"','"&sportid&"','"&leagueid&"','"&visitorNum&"');"">"
									response.write "<a href='javascript:void(0)' class='"&linkspreadclass&"'>"&showVisitorSpread&"</a>"&vbcr
								else 
									response.write ">&nbsp;"
								end if
							end if				
							response.write "</div>"&vbcr

							response.write "<div class='betting-lines-line-line' id='"&gameid&"_2_Ov'"
							if overTotal <> "" then
								response.write " onclick=""addbet('2','"&gameid&"','Ov','"&linkVisitorTeam&"','"&overTotal&"','"&overTotalOdds&"','"&sportid&"','"&leagueid&"','"&visitorNum&"');"">"
								response.write "<a href='javascript:void(0)' class='"&linktotalclass&"'>Ov "&showTotalOver&"</a>"&vbcr
							else 
								response.write ">&nbsp;"
							end if				
							response.write "</div>"&vbcr

							response.write "<div class='betting-lines-line-line-ml' id='"&gameid&"_4_ML'"
							if visitorML <> "" then
								response.write " onclick=""addbet('4','"&gameid&"','ML','"&linkVisitorTeam&"','0','"&visitorML&"','"&sportid&"','"&leagueid&"','"&homeNum&"');"">"
								response.write "<a href='javascript:void(0)' class='"&linkmlclass&"'>"&symbol&Trim(showVisitorML)&"</a>"&vbcr
							else 
								response.write ">&nbsp;"
							end if
							response.write "</div>"&vbcr
							
							response.write "</div>"&vbcr
							
							response.write "<div class='betting-lines-line evn'>"&vbcr
							response.write "<div class='betting-lines-line-rot'>"&homeNum&"</div>"&vbcr
							response.write "<div class='betting-lines-line-name'>"&homeName&" <span class='classpitcher"
							if pitcherChange = 2 or pitcherChange = 3 then
								response.write " pitcherchange"
							end if
							response.write "'>"&homePitcher&"</span></div>"&vbcr
							
							response.write "<div class='betting-lines-line-line' id='"&gameid&"_1_S'"
							if Trim(sportid) = "NHL" and NHLLine = "C" then
								if homeSpecialSpread <> "" then
									response.write " onclick=""addbet('1','"&gameid&"','S','"&linkHomeTeam&"','"&homeSpecialSpread&"','"&homeSpecialSpreadOdds&"','"&sportid&"','"&leagueid&"','"&homeNum&"');"">"
									response.write "<a href='javascript:void(0)' class='"&linkspreadclass&"'>"&showHomeSpecialSpread&"</a>"&vbcr
								else 
									response.write ">&nbsp;"
								end if
							else
								if homeSpread <> "" then
									response.write "  onclick=""addbet('1','"&gameid&"','S','"&linkHomeTeam&"','"&homeSpread&"','"&homeSpreadOdds&"','"&sportid&"','"&leagueid&"','"&homeNum&"');"">"
									response.write "<a href='javascript:void(0)' class='"&linkspreadclass&"'>"&showHomeSpread&"</a>"&vbcr
								else 
									response.write ">&nbsp;"
								end if
							end if
							response.write "</div>"&vbcr

							response.write "<div class='betting-lines-line-line' id='"&gameid&"_3_Un'"
							if underTotal <> "" then
								response.write " onclick=""addbet('3','"&gameid&"','Un','"&linkHomeTeam&"','"&underTotal&"','"&underTotalOdds&"','"&sportid&"','"&leagueid&"','"&homeNum&"');"">"
								response.write "<a href='javascript:void(0)' class='"&linktotalclass&"'>Un "&showTotalUnder&"</a>"&vbcr
							else 
								response.write ">&nbsp;"
							end if
							response.write "</div>"&vbcr

							response.write "<div class='betting-lines-line-line-ml' id='"&gameid&"_5_ML'"
							if homeML <> "" then
								response.write " onclick=""addbet('5','"&gameid&"','ML','"&linkHomeTeam&"','0','"&homeML&"','"&sportid&"','"&leagueid&"','"&homeNum&"');"">"
								response.write "<a href='javascript:void(0)' class='"&linkmlclass&"'>"&symbol&Trim(showHomeML)&"</a>"&vbcr
							else 
								response.write ">&nbsp;"
							end if				
							response.write "</div>"&vbcr

							response.write "</div>"&vbcr
		
							if sportid = "SOC" and visitorSpecialSpreadOdds <> "" then
								drawNum = Int(homeNum)+1
								
								if visitorSpecialSpreadOdds > 0 then
									if LineStyle = "D" then
										showvisitorSpecialSpreadOdds = (visitorSpecialSpreadOdds/100) + 1
										showvisitorSpecialSpreadOdds = "+"&FormatNumber(showvisitorSpecialSpreadOdds,,,0)
									else
										showvisitorSpecialSpreadOdds = "+"&visitorSpecialSpreadOdds
									end if
								else
									if LineStyle = "D" then
										showvisitorSpecialSpreadOdds = (100/visitorSpecialSpreadOdds) + 1
										showvisitorSpecialSpreadOdds = "+"&FormatNumber(showvisitorSpecialSpreadOdds,,,0)
									else
										showvisitorSpecialSpreadOdds = "-"&visitorSpecialSpreadOdds
									end if
								end if
								response.write "<div class='betting-lines-line betting-lines-line-top odd'>"&vbcr
								response.write "<div class='betting-lines-line-rot'>"&drawNum&"</div>"&vbcr
								response.write "<div class='betting-lines-line-name'>DRAW</div>"&vbcr
								response.write "<div class='betting-lines-line-line'>&nbsp;</div>"&vbcr
								response.write "<div class='betting-lines-line-line'>&nbsp;</div>"
								response.write "<div class='betting-lines-line-line-ml' id='"&gameid&"_6_Draw'"
								if visitorSpecialSpreadOdds <> "" then
									response.write " onclick=""addbet('6','"&gameid&"','Draw','"&homeName&"','0','"&visitorSpecialSpreadOdds&"','"&sportid&"','"&leagueid&"','"&drawNum&"');"">"
									response.write "<a href='javascript:void(0)' class='"&linkmlclass&"'>"&showvisitorSpecialSpreadOdds&"</a>"
								else 
									response.write ">&nbsp;"
								end if				
								response.write "</div>"&vbcr
								response.write "</div>"&vbcr
							end if
		
							//betting-lines-line-container
							response.write "</div>"&vbcr
							response.write "<div class='betting-lines-datetime "
							if idgametype = 10 then
								response.write "circled"
							end if
							response.write " visible-xs'>"&strFullDate&"</div>"&vbcr
							response.write "</div>"&vbcr							
						end if
					
					end if

				next

			next

		end if
	end if
	
	if not sports then
		response.write "Please Select Sports from the Betting Menu"
	end if

end function

function getPitcherChange (gameid)

	pc = 0

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE Game_GetStatusGame @prmIdGame = "&gameid
	rs.Open sqlStr, c
	
	IF NOT rs.EOF then
		pc = rs("PitcherChanged")
	END IF

	rs.Close
	Set rs = Nothing
	
	getPitcherChange = pc

end function

function getPlayerCredit(pid)

	CreditLimit = 0

//	url = Application("DGSproxy")&"/proxyplayer.asmx/GetPlayerBalance"
	url = "http://10.1.1.4:8000/proxyplayer.asmx/GetPlayerBalance"
	Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
	http.open "POST", url, false

	formData = "prmIdPlayer=" & pid
	formData = formData & "&prmCurrencyCode="

//	http.setRequestHeader "CharSet", "UTF-8"
	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)
//	http.setRequestHeader "lastCached", now()
	http.send formData
	ndResponse = http.responseText

	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")

	Dim ndXML
	Dim isValid
	Set ndXML = CreateObject("Microsoft.XmlDom")
	isValid = ndXML.loadXML(ndResponse)

	if isValid then
		set x = ndXML.getElementsByTagName("xml")

		for each objEvent in x
			errcode = objEvent.getAttribute("ErrorCode")
			errmsg = objEvent.getAttribute("ErrorMsg")
			CreditLimit = objEvent.getAttribute("CreditLimit") 
		next
	end if

	if (Not isValid) then 
		response.write "<p>There was an error processing your account.</p>"
	end if

	getPlayerCredit = CreditLimit

end function

function getParlayOdds(teams,pid)

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE GetParlayOdds @prmNumTeams = "&teams&", @prmIdPlayer = "&pid&""
	rs.Open sqlStr, c
	
	IF NOT rs.EOF then
		response.write "<input type='hidden' name='p_odds' id='p_odds' value='"&rs("Odds")&"'>"&vbcr
	END IF

	rs.Close
	Set rs = Nothing
		
end function

function getTeasers(pid,bet_count)

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE GetTeaserValues @prmIdPlayer = "&pid&""
	rs.Open sqlStr, c

	response.write "<select name='ts' id='ts' class='sl' onChange='refresh_teaser(this)'>"
	response.write "<option value='' selected='selected'>Please choose a Teaser</option>"&vbcr
	WHILE NOT rs.EOF
		if bet_count <> "" then
			if Int(rs("TeaserSize")) = Int(bet_count) then
//				response.write rs("TeaserSize")&" "&bet_count&"<br>"
//				tfull = rs("IdWagerType")&"_"&rs("Name")&"_"&rs("TeaserSize")&"_"&rs("Odds")&"_"&rs("BuyHalf")&"_"&rs("Buy1")&"_"&rs("NFLSide")&"_"&rs("NBASide")
//				response.write "<option value='"&tfull&"'>"&rs("Name")&"</option>"&vbcr	
				response.write "<option value='"&rs("IdWagerType")&"'>"&rs("Name")&"</option>"&vbcr	
			end if
		else
//			tfull = rs("IdWagerType")&"_"&rs("Name")&"_"&rs("TeaserSize")&"_"&rs("Odds")&"_"&rs("BuyHalf")&"_"&rs("Buy1")&"_"&rs("NFLSide")&"_"&rs("NBASide")
			response.write "<option value='"&rs("IdWagerType")&"'>"&rs("Name")&"</option>"&vbcr
		end if
		rs.MoveNext
	WEND
	response.write "</select>"

	rs.Close
	Set rs = Nothing
	
end function

function getIdWagerType(idp,wtype,numteams)

	idwagertype = 0

	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "SELECT IdWagerType FROM WAGERTYPE WHERE IdProfile = '"&idp&"' AND WagerType = '"&wtype&"'"
	if wtype = 1 or wtype = 2 then
		sqlStr = sqlStr + " AND NumTeams = '"&numteams&"'"
	end if
	rs.Open sqlStr, c

	IF NOT rs.EOF then
		idwagertype = rs("IdWagerType")
	END IF

	getIdWagerType = idwagertype
	
	rs.Close
	Set rs = Nothing

end function

function getNSS(gameid,team)

	Set rs = CreateObject("ADODB.Recordset")
	
	sqlStr = "EXECUTE Game_GetTeamsInfo @prmIdGame = "&gameid
//	response.write sqlStr

	rs.Open sqlStr, c

	IF NOT rs.EOF then
		Session("vt") = rs("VisitorTeam")
		Session("ht") = rs("HomeTeam")
		if team = rs("VisitorTeam") then
			nss = rs("VisitorNumber")
		else
			nss = rs("HomeNumber")
		end if
	END IF
	
	getNSS = nss

	rs.Close
	Set rs = Nothing

end function

function getTeamName(gameid,play)

	Set rs = CreateObject("ADODB.Recordset")
	
	sqlStr = "EXECUTE Game_GetTeamsInfo @prmIdGame = "&gameid
//	response.write sqlStr

	rs.Open sqlStr, c

	IF NOT rs.EOF then
		if play = 0 or play = 2 or play = 4 then
			response.write rs("VisitorTeam")
		elseif play = 1 or play = 3 or play = 5 then
			response.write rs("HomeTeam")
		end if
	END IF
	
	rs.Close
	Set rs = Nothing

end function

function getsportID(gameid)

	sportID = ""

	Set rs = CreateObject("ADODB.Recordset")
	
	sqlStr = "EXECUTE [Games_GetGame] @prmIdGame = "&gameid
//	response.write sqlStr

	rs.Open sqlStr, c

	IF NOT rs.EOF then
		sportID = rs("IdSport")
	END IF
	
	rs.Close
	Set rs = Nothing

	getsportID = sportID

end function

function compilebet (prm,idp,idcall,wt,os,idwt)

	Dim http, url, formData, ndResponse
//	url = Application("DGSproxy")&"/proxywager.asmx/WagerCompile"
	url = "http://10.1.1.4:8000/proxywager.asmx/WagerCompile"
	
	Set http = CreateObject("MSXML2.ServerXMLHTTP.6.0")
	http.open "POST", url, false

	formData = "prmdetails=" & prm
	formData = formData & "&IdPlayer=" & idp
	formData = formData & "&IdCall=" & idcall
	formData = formData & "&WagerType=" & wt
	formData = formData & "&OpenSpots=" & os
	formData = formData & "&IdWagerType=" & idwt
//	response.write formData
	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)

	http.send formData

	ndResponse = http.responseText
//	response.write ndResponse
	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")
	ndResponse = Replace(ndResponse,"&amp;amp;","&amp;")
	ndResponse = Replace(ndResponse,"&amp;amp;frac12;","&amp;frac12;")
	ndResponse = Replace(ndResponse,"&amp;lt;BR&amp;gt;","&lt;BR&gt;")

	compilebet = ndResponse

end function


function confirmbet (prmslip,prmdetails)

	Dim http, url, formData, ndResponse
	url = "http://10.1.1.4:8000/proxywager.asmx/WagerConfirm"
	Set http = CreateObject("Microsoft.XMLHTTP")
	http.open "POST", url, false

	formData = "slip=" & Server.URLEncode(prmslip)
	formData = formData & "&prmdetails=" & Server.URLEncode(prmdetails)

//	response.write prmslip
//	response.write formData

	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)

	http.send formData
	ndResponse = http.responseText
	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")
	ndResponse = Replace(ndResponse,"&amp;amp;","&amp;")
	ndResponse = Replace(ndResponse,"&amp;lt;BR&amp;gt;","&lt;BR&gt;")

	confirmbet = ndResponse

//	response.write ndResponse

end function


function postbet (prmslip,pwd)

	Dim http, url, formData, ndResponse
	url = "http://10.1.1.4:8000/proxywager.asmx/WagerPost "
	Set http = CreateObject("Microsoft.XMLHTTP")
	http.open "POST", url, false

	formData = "slip=" & Server.URLEncode(prmslip)
	formData = formData & "&Password=" & pwd

	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)

	http.send formData
	ndResponse = http.responseText
	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")
	ndResponse = Replace(ndResponse,"&amp;lt;BR&amp;gt;","&lt;BR&gt;")

//	response.write ndResponse

	postbet = ndResponse

end function

function getTeasersList (idp,bc)

	Dim http, url, formData, ndResponse
	url = "http://10.1.1.4:8000/proxywager.asmx/GetTeasers"
	Set http = CreateObject("Microsoft.XMLHTTP")
	http.open "POST", url, false

	formData = "IdProfile=" & idp

	http.setRequestHeader "Content-Type", "application/x-www-form-urlencoded"
	http.setRequestHeader "Content-Length", Len(formData)

	http.send formData
	ndResponse = http.responseText
	ndResponse = Replace(ndResponse,"&lt;","<")
	ndResponse = Replace(ndResponse,"&gt;",">")

	Dim ndXML
	Dim isValid
	Set ndXML = CreateObject("Microsoft.XmlDom")
	isValid = ndXML.loadXML(ndResponse)

	if isValid then
	
		set x = ndXML.getElementsByTagName("xml")
	
		for each objEvent in x
			errorcode = objEvent.getAttribute("ErrorCode")
			errormsg = objEvent.getAttribute("ErrorMsg")
			if errorcode = 0 then
				response.write "<select name='ts' id='ts' onChange='refresh_teaser(this)' class='form-control input-sm'>"
				response.write "<option value='' selected='selected'>Please choose a Teaser</option>"&vbcr
				set t = objEvent.getElementsByTagName("teaser")
				for each teaser in t
					teasersize = teaser.getAttribute("TeaserSize")
					teasername = teaser.getAttribute("Name")
					teaseridwt = teaser.getAttribute("IDWT")
					if CInt(bc) = CInt(teasersize) then
						response.write "<option value='"&teaseridwt&"'>"&Replace(teasername,"&amp;frac12;","&frac12;")&"</option>"&vbcr
					end if
				next
				response.write "</select>"
			else
				response.write "Error : "&errormsg
			end if
		next
	end if

end function

function getTeaserInfo(pid,idwt)

	Dim teaserInfo(8)
	Set rs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE GetTeaserValues @prmIdPlayer = "&pid&""
	rs.Open sqlStr, c

	WHILE NOT rs.EOF
		if Int(rs("IdWagerType")) = Int(idwt) then
			//Session("NFLSide") =  rs("NFLSide")
			//Session("NFLTotal") = rs("NFLTotal")
			//Session("NBASide") = rs("NBASide")
			//Session("NBATotal") = rs("NBATotal")
			//Session("CFBSide") =  rs("CFBSide")
			//Session("CFBTotal") = rs("CFBTotal")
			//Session("CBBSide") = rs("CBBSide")
			//Session("CBBTotal") = rs("CBBTotal")
			//Session("TeaserOdds") = rs("Odds")
			teaserInfo(0) = rs("NFLSide")
			teaserInfo(1) = rs("NFLTotal")
			teaserInfo(2) = rs("NBASide")
			teaserInfo(3) = rs("NBATotal")
			teaserInfo(4) = rs("CFBSide")
			teaserInfo(5) = rs("CFBTotal")
			teaserInfo(6) = rs("CBBSide")
			teaserInfo(7) = rs("CBBTotal")
			teaserInfo(8) = rs("Odds")
		end if
		rs.MoveNext
	WEND

	rs.Close
	Set rs = Nothing
	
	getTeaserInfo = teaserInfo
	
end function

Function getRRCombo(betcount)

	if betcount > 1 then
		response.write "<select name='combo' id='combo' class='form-control'>"
		if betcount = 2 then
			response.write "<option value='2'>1 Parlay of 2 Teams</option>"&vbcr
		elseif betcount = 3 then
			//response.write "<option value='2'>3 Parlays of 2 Teams</option>"&vbcr
			//response.write "<option value='3'>1 Parlay of 3 Teams</option>"&vbcr
			response.write "<option value='2'>Round Robin with 2T</option>"&vbcr
			response.write "<option value='2,3'>Round Robin with 2T,3T</option>"&vbcr
		elseif betcount = 4 then
			//response.write "<option value='2'>6 Parlays of 2 Teams</option>"&vbcr
			//response.write "<option value='3'>4 Parlays of 3 Teams</option>"&vbcr
			//response.write "<option value='4'>1 Parlay of 4 Teams</option>"&vbcr
			response.write "<option value='2'>Round Robin with 2T</option>"&vbcr
			response.write "<option value='2,3'>Round Robin with 2T,3T</option>"&vbcr
			response.write "<option value='2,3,4'>Round Robin with 2T,3T,4T</option>"&vbcr
			response.write "<option value='3'>Round Robin with 3T</option>"&vbcr
			response.write "<option value='3,4'>Round Robin with 3T,4T</option>"&vbcr
		elseif betcount = 5 then
			//response.write "<option value='2'>10 Parlays of 2 Teams</option>"&vbcr
			//response.write "<option value='3'>10 Parlays of 3 Teams</option>"&vbcr
			//response.write "<option value='4'>5 Parlays of 4 Teams</option>"&vbcr
			//response.write "<option value='5'>1 Parlay of 5 Teams</option>"
			response.write "<option value='2'>Round Robin with 2T</option>"&vbcr
			response.write "<option value='2,3'>Round Robin with 2T,3T</option>"&vbcr
			response.write "<option value='2,3,4'>Round Robin with 2T,3T,4T</option>"&vbcr
			response.write "<option value='2,3,4,5'>Round Robin with 2T,3T,4T,5T</option>"&vbcr
			response.write "<option value='3'>Round Robin with 3T</option>"&vbcr
			response.write "<option value='3,4'>Round Robin with 3T,4T</option>"&vbcr
			response.write "<option value='3,4,5'>Round Robin with 3T,4T,5T</option>"&vbcr
			//response.write "<option value='4'>Round Robin with 4T</option>"&vbcr
		elseif betcount = 6 then
			//response.write "<option value='2'>15 Parlays of 2 Teams</option>"&vbcr
			//response.write "<option value='3'>20 Parlays of 3 Teams</option>"&vbcr
			//response.write "<option value='4'>15 Parlays of 4 Teams</option>"&vbcr
			//response.write "<option value='5'>6 Parlays of 5 Teams</option>"&vbcr
			//response.write "<option value='6'>1 Parlay of 6 Teams</option>"
			response.write "<option value='2'>Round Robin with 2T</option>"&vbcr
			response.write "<option value='2,3'>Round Robin with 2T,3T</option>"&vbcr
			response.write "<option value='2,3,4'>Round Robin with 2T,3T,4T</option>"&vbcr
			response.write "<option value='2,3,4,5'>Round Robin with 2T,3T,4T,5T</option>"&vbcr
			response.write "<option value='2,3,4,5,6'>Round Robin with 2T,3T,4T,5T,6T</option>"&vbcr
			response.write "<option value='3'>Round Robin with 3T</option>"&vbcr
			response.write "<option value='3,4'>Round Robin with 3T,4T</option>"&vbcr
			response.write "<option value='3,4,5'>Round Robin with 3T,4T,5T</option>"&vbcr
			response.write "<option value='3,4,5,6'>Round Robin with 3T,4T,5T,6T</option>"&vbcr
		end if
		response.write "</select>"
	else 
		response.write "error, invalid count of teams"
	end if
End Function

Function UpdatePlayer(pid,pass,name,lname,address,city,state,country,zip,phone)

	if pid <> "" then
		sqlStr = "UPDATE Player SET Password = '"&pass&"', OnlinePassword = '"&pass&"', Name = '"&name&"', LastName = '"&lname&"', Address1 = '"&address&"', "&_
				 "City = '"&city&"', State = '"&state&"', Country='"&country&"', Zip = '"&zip&"', Phone = '"&phone&"' WHERE IdPlayer = '"&pid&"'"
//		response.write sqlStr
		conn.Execute (sqlStr)
	else
		response.write "Error: missing information."
	end if

End Function


Function checkHold (pid,bethead,betdesc,betrisk,betwin)

	Session("holdBets") = 0
	Session("holdDelay") = 0
	
	Set rs = CreateObject("ADODB.Recordset")
	
	sqlStr = "SELECT HoldBets, HoldDelay FROM PLAYER WHERE IdPlayer = "&pid

	rs.Open sqlStr, c

	IF NOT rs.EOF then
		Session("holdBets") = rs("HoldBets")
		Session("holdDelay") = rs("HoldDelay")
	END IF
	
	rs.Close
	Set rs = Nothing
	
	if Session("holdBets") then
		
		if Session("holdSession") = 0 then
			Randomize
			Session("holdSession") = Rnd
		end if
		
		p = GetPlayer (pid)
		
		sqlStr = "INSERT INTO _web_holdBets (Player, BetHeader, BetDesc, BetRisk, BetWin,IdSession, Status) "&_
				"VALUES ('"&p&"','"&bethead&"','"&betdesc&"',"&betrisk&","&betwin&","&Session("holdSession")&",'pending')"
		c.Execute (sqlStr)
	end if
	
End Function

Function updateHold (wagerID)


	sqlStr = "UPDATE _web_holdBets SET IdWager = '"&wagerID&"', Status = 'complete' WHERE IdSession = '"&Session("holdSession")&"'"
//		response.write sqlStr
	c.Execute (sqlStr)
	
	Session("holdSession") = 0
	
End Function

Function sentEmail (pid)

	sent = false
	
	Set rs = CreateObject("ADODB.Recordset")
	
	sqlStr = "SELECT IDPlayer FROM ITWagerWatch WHERE IdPlayer = "&pid

	rs.Open sqlStr, c

	IF NOT rs.EOF then
		sent = true
	END IF
	
	rs.Close
	Set rs = Nothing

	sentEmail = sent
	
End Function

Function getEmailAgent (pid)

	e = ""
	
	Set rs = CreateObject("ADODB.Recordset")
	
//	sqlStr = "select player.idagent, DBAWebAlertAgentConfig.email from player, DBAWebAlertAgentConfig "&_
//	"where player.idplayer = '"&pid&"' and player.idagent = DBAWebAlertAgentConfig.idagent "

	sqlStr = "SELECT MailTo FROM ITWagerWatch WHERE IdPlayer = "&pid

	rs.Open sqlStr, c

	IF NOT rs.EOF then
		e = rs("MailTo")
	END IF
	
	rs.Close
	Set rs = Nothing

	getEmailAgent = e
	
End Function

Function SendEmailBet(pid,bet)

	account = getPlayer (pid)
	email = getEmailAgent (pid)
	
	if account <> "" and email <> "" then
		Dim ObjSendMail
		Set ObjSendMail = CreateObject("CDO.Message") 
							 
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2 'Send the message using the network (SMTP over the network).
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "10.1.1.20"
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25 
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False 'Use SSL for the connection (True or False)
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
			 
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1 'basic (clear-text) authentication
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendusername") = "alert@ccs.cr"
		ObjSendMail.Configuration.Fields.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "alert123"
			 
		ObjSendMail.Configuration.Fields.Update
			 
		ObjSendMail.To = email
		ObjSendMail.Subject = "Bet has been placed"
		ObjSendMail.From = "alert@ccs.cr"

		ObjSendMail.HTMLBody = "<p align='right'><img src='http://www.wagershack.com/assets/images/logo.png'></p>" &_
		"<p>Account:  "&account&" has placed a bet.</p>" &_
		"<p>Bet Description: <br> "&bet&".</p>" &_
		"<p>Customer Support</p>"

		ObjSendMail.Send	
	end if
End Function

function getPlayerParlayLimit (profileID, teams)

	maxdog = 0
	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "EXECUTE WebGetParlayLimitData @prmIdProfile = "&profileID&", @prmNumTeams = "&teams
	recs.Open sqlStr, c
		
	IF NOT recs.EOF THEN
		maxdog = recs("MaxDogLines")
	END IF
	
	recs.Close
	Set recs = Nothing
	
	getPlayerParlayLimit = maxdog
	
end function

function getPlayerParlayMaxDog (profileID)

	//maxdogML = 0
	//maxdogSP = 1
	//maxdogTT = 3
	Dim maxdog(2)
	Set recs = CreateObject("ADODB.Recordset")
	sqlStr = "select PL_MaxDogsMoney, PL_MaxDogsSide, PL_MaxDogsTotal from PLAYERPROFILE where IdProfile = "&profileID
	recs.Open sqlStr, c
		
	IF NOT recs.EOF THEN
		maxdog(0) = recs("PL_MaxDogsMoney")
		maxdog(1) = recs("PL_MaxDogsSide")
		maxdog(2) = recs("PL_MaxDogsTotal")
	END IF
	
	recs.Close
	Set recs = Nothing
	
	getPlayerParlayMaxDog = maxdog
	
end function
</script>
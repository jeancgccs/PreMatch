<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.CacheControl = "no-cache" %>
<!--#include file = "inc/common.asp"-->
<!--#include file = "inc/db.asp"-->
<%
	action = Request.QueryString("action")
    fixtureID = Request.QueryString("fid")
	
	if action = "" then
%>

<!DOCTYPE html>
<html lang="en">
<head>

	<meta charset="utf-8">
	<meta content="width=device-width, initial-scale=1, shrink-to-fit=no" name="viewport">
	<meta name="description" content="">
	<link rel="icon" href="assets/img/brand/favicon.ico" type="image/x-icon"/>
	<title>PRE Match</title>
	<link id="style" href="assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
	<link href="assets/web-fonts/icons.css" rel="stylesheet"/>
	<link href="assets/web-fonts/font-awesome/font-awesome.min.css" rel="stylesheet">
	<link href="assets/web-fonts/plugin.css" rel="stylesheet"/>
	<link href="assets/css/style.css" rel="stylesheet">
	<link href="assets/css/transparent-style.css" rel="stylesheet">
	<link href="assets/css/dark-style.css" rel="stylesheet">
	<link href="assets/css/skin-modes.css" rel="stylesheet">
	<link href="assets/css/colors/color.css" id="theme" rel="stylesheet" type="text/css" media="all">
	<link href="assets/switcher/demo.css" rel="stylesheet"/>
	<link href="assets/css/custom.css" rel="stylesheet"/>

</head>

<body class="main-body leftmenu ltr light-theme dark-menu">

	<!-- Loader -->
	<div id="global-loader">
		<img src="assets/img/loader.svg" class="loader-img" alt="Loader">
	</div>
	<!-- End Loader -->

	<!-- Page -->
	<div class="page">

		<!-- Main Header-->
		<div class="main-header side-header sticky">
			<div class="main-container container-fluid">
				<div class="main-header-left">
					<a class="main-header-menu-icon" href="javascript:;" id="mainSidebarToggle">
						<svg class="header-menu-icon" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24"><path d="M2.5,10.5h11c0.276123,0,0.5-0.223877,0.5-0.5s-0.223877-0.5-0.5-0.5h-11C2.223877,9.5,2,9.723877,2,10S2.223877,10.5,2.5,10.5z M2.5,6.5h19C21.776123,6.5,22,6.276123,22,6s-0.223877-0.5-0.5-0.5h-19C2.223877,5.5,2,5.723877,2,6S2.223877,6.5,2.5,6.5z M21.8446045,9.3519897C21.609314,9.0689697,21.189209,9.0303345,20.90625,9.265625l-2.6660156,2.2226562c-0.0315552,0.0261841-0.0606079,0.0552368-0.086792,0.086792c-0.2346802,0.2826538-0.1958008,0.7019653,0.086792,0.9366455L20.90625,14.734375c0.1194458,0.1005249,0.2706299,0.1555176,0.4267578,0.1552734c0.1973267-0.0002441,0.3843994-0.0878906,0.5109253-0.2393188c0.236145-0.2826538,0.1984863-0.7032471-0.0841675-0.9393921L19.7080078,12l2.0517578-1.7109375C22.0414429,10.0534668,22.0794067,9.6343384,21.8446045,9.3519897z M2.5,14.5h11c0.276123,0,0.5-0.223877,0.5-0.5s-0.223877-0.5-0.5-0.5h-11C2.223877,13.5,2,13.723877,2,14S2.223877,14.5,2.5,14.5z M21.5,17.5h-19C2.223877,17.5,2,17.723877,2,18s0.223877,0.5,0.5,0.5h19c0.276123,0,0.5-0.223877,0.5-0.5S21.776123,17.5,21.5,17.5z"/></svg>
					</a>
					<div class="hor-logo">
						<a class="main-logo" href="index.html">
							<img src="assets/img/brand/logo.png" class="header-brand-img desktop-logo" alt="logo">
							<img src="assets/img/brand/logo-light.png" class="header-brand-img desktop-logo-dark" alt="logo">
						</a>
					</div>
				</div>
				<div class="main-header-center">
					<div class="responsive-logo">
						<a href="index.html"><img src="assets/img/brand/logo.png" class="mobile-logo" alt="logo"></a>
						<a href="index.html"><img src="assets/img/brand/logo-light.png" class="mobile-logo-dark" alt="logo"></a>
					</div>
					<div class="input-group">
						<input type="search" class="form-control rounded-0" placeholder="Search for anything...">
						<button class="btn search-btn"><i class="fe fe-search"></i></button>
					</div>
				</div>
				<div class="main-header-right">
					<button class="navbar-toggler navresponsive-toggler d-md-none ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent-4" aria-controls="navbarSupportedContent-4" aria-expanded="false" aria-label="Toggle navigation">
						<svg class="header-icons navbar-toggler-icon" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24"><path d="M12,7c1.1040039-0.0014038,1.9985962-0.8959961,2-2c0-1.1045532-0.8954468-2-2-2s-2,0.8954468-2,2S10.8954468,7,12,7z M12,4c0.552124,0.0003662,0.9996338,0.447876,1,1c0,0.5523071-0.4476929,1-1,1s-1-0.4476929-1-1S11.4476929,4,12,4z M12,10c-1.1045532,0-2,0.8954468-2,2s0.8954468,2,2,2c1.1040039-0.0014038,1.9985962-0.8959961,2-2C14,10.8954468,13.1045532,10,12,10z M12,13c-0.5523071,0-1-0.4476929-1-1s0.4476929-1,1-1c0.552124,0.0003662,0.9996338,0.447876,1,1C13,12.5523071,12.5523071,13,12,13z M12,17c-1.1045532,0-2,0.8954468-2,2s0.8954468,2,2,2c1.1040039-0.0014038,1.9985962-0.8959961,2-2C14,17.8954468,13.1045532,17,12,17z M12,20c-0.5523071,0-1-0.4476929-1-1s0.4476929-1,1-1c0.552124,0.0003662,0.9996338,0.447876,1,1C13,19.5523071,12.5523071,20,12,20z"/></svg>
					</button>
					<div class="navbar navbar-expand-lg navbar-collapse responsive-navbar">
						<div class="collapse navbar-collapse" id="navbarSupportedContent-4">
							<div class="d-flex order-lg-2 ms-auto">
								<div class="dropdown header-search">
									<a class="nav-link icon header-search">
										<svg class="header-icons" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24"><path d="M21.2529297,17.6464844l-2.8994141-2.8994141c-0.0021973-0.0021973-0.0043945-0.0043945-0.0065918-0.0065918c-0.8752441-0.8721313-2.2249146-0.9760132-3.2143555-0.3148804l-0.8467407-0.8467407c1.0981445-1.2668457,1.7143555-2.887146,1.715332-4.5747681c0.0021973-3.8643799-3.1286621-6.9989014-6.993042-7.0011597S2.0092773,5.1315308,2.007019,8.9959106S5.1356201,15.994812,9,15.9970703c1.6889038,0.0029907,3.3114014-0.6120605,4.5789185-1.7111206l0.84729,0.84729c-0.6630859,0.9924316-0.5566406,2.3459473,0.3208618,3.2202759l2.8994141,2.8994141c0.4780884,0.4786987,1.1271973,0.7471313,1.8037109,0.7460938c0.6766357,0.0001831,1.3256226-0.2686768,1.803894-0.7472534C22.2493286,20.2558594,22.2488403,18.6417236,21.2529297,17.6464844z M9.0084229,14.9970703c-3.3120728,0.0023193-5.9989624-2.6807861-6.0012817-5.9928589S5.6879272,3.005249,9,3.0029297c1.5910034-0.0026855,3.1175537,0.628479,4.2421875,1.7539062c1.1252441,1.1238403,1.7579956,2.6486206,1.7590942,4.2389526C15.0036011,12.3078613,12.3204956,14.994751,9.0084229,14.9970703z M20.5458984,20.5413818c-0.604126,0.6066284-1.5856934,0.6087036-2.1923828,0.0045166l-2.8994141-2.8994141c-0.2913818-0.2910156-0.4549561-0.6861572-0.4544678-1.0979614C15.0006714,15.6928101,15.6951294,15,16.5507812,15.0009766c0.4109497-0.0005493,0.8051758,0.1624756,1.0957031,0.453125l2.8994141,2.8994141C21.1482544,18.9584351,21.1482544,19.9364624,20.5458984,20.5413818z"/></svg>
									</a>
									<div class="dropdown-menu">
										<div class="main-form-search p-2">
											<div class="input-group">
												<div class="input-group-btn search-panel">
												</div>
												<input type="search" class="form-control" placeholder="Search for anything...">
												<button class="btn search-btn"><i class="fe fe-search"></i></button>
											</div>
										</div>
									</div>
								</div>
								<!--search-->
								<div class="dropdown d-flex main-profile-menu">
									<a class="d-flex" href="javascript:;">
										<span class="main-img-user">
											<img alt="avatar" src="assets/img/users/6.jpg">
										</span>
									</a>
									<div class="dropdown-menu">
										<div class="header-navheading">
											<h6 class="main-notification-title">DGS User</h6>
										</div>
										<a class="dropdown-item" href="signin.html">
											<i class="fe fe-power"></i> Sign Out
										</a>
									</div>
								</div><!-- profile -->
								<div class="dropdown d-flex header-settings">
									<a href="javascript:;" class="nav-link icon" data-bs-toggle="sidebar-right" data-bs-target=".sidebar-right">
										<svg class="header-icons" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24"><path d="M21.5,17h-19C2.223877,17,2,17.223877,2,17.5S2.223877,18,2.5,18h19c0.276123,0,0.5-0.223877,0.5-0.5S21.776123,17,21.5,17z M2.5,8h19C21.776123,8,22,7.776123,22,7.5S21.776123,7,21.5,7h-19C2.223877,7,2,7.223877,2,7.5S2.223877,8,2.5,8z M21.5,12h-19C2.223877,12,2,12.223877,2,12.5S2.223877,13,2.5,13h19c0.276123,0,0.5-0.223877,0.5-0.5S21.776123,12,21.5,12z"/></svg>
									</a>
								</div><!-- header settings -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Main Header-->

		<!-- Sidemenu -->
		<div class="sticky">
			<div class="main-menu main-sidebar main-sidebar-sticky side-menu">
				<div class="main-sidebar-header main-container-1 active">
					<div class="sidemenu-logo">
						<a class="main-logo" href="index.html">
							<img src="assets/img/brand/logo-light.png" class="header-brand-img desktop-logo-dark" alt="logo">
							<img src="assets/img/brand/icon-light.png" class="header-brand-img icon-logo-dark" alt="logo">
							<img src="assets/img/brand/logo.png" class="header-brand-img desktop-logo" alt="logo">
							<img src="assets/img/brand/icon.png" class="header-brand-img icon-logo" alt="logo">
						</a>
					</div>
					<div class="main-sidebar-body main-body-1">
						<div class="slide-left disabled" id="slide-left"><svg xmlns="http://www.w3.org/2000/svg" fill="#c9bebe" width="24" height="24" viewBox="0 0 24 24"><path d="M13.293 6.293 7.586 12l5.707 5.707 1.414-1.414L10.414 12l4.293-4.293z"/></svg></div>
						<ul class="menu-nav nav">
							<li class="nav-item">
								<a class="nav-link with-sub" href="dashboard.html">
									<svg class="sidemenu-icon menu-icon" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24"><path d="M21.5,13h-8.0005493C13.2234497,13.0001831,12.9998169,13.223999,13,13.5v8.0005493C13.0001831,21.7765503,13.223999,22.0001831,13.5,22h8.0006104C21.7765503,21.9998169,22.0001831,21.776001,22,21.5v-8.0006104C21.9998169,13.2234497,21.776001,12.9998169,21.5,13z M21,21h-7v-7h7V21z M10.5,2H2.4993896C2.2234497,2.0001831,1.9998169,2.223999,2,2.5v8.0005493C2.0001831,10.7765503,2.223999,11.0001831,2.5,11h8.0006104C10.7765503,10.9998169,11.0001831,10.776001,11,10.5V2.4993896C10.9998169,2.2234497,10.776001,1.9998169,10.5,2z M10,10H3V3h7V10z M10.5,13H2.4993896C2.2234497,13.0001831,1.9998169,13.223999,2,13.5v8.0005493C2.0001831,21.7765503,2.223999,22.0001831,2.5,22h8.0006104C10.7765503,21.9998169,11.0001831,21.776001,11,21.5v-8.0006104C10.9998169,13.2234497,10.776001,12.9998169,10.5,13z M10,21H3v-7h7V21z M21.5,2h-8.0005493C13.2234497,2.0001831,12.9998169,2.223999,13,2.5v8.0005493C13.0001831,10.7765503,13.223999,11.0001831,13.5,11h8.0006104C21.7765503,10.9998169,22.0001831,10.776001,22,10.5V2.4993896C21.9998169,2.2234497,21.776001,1.9998169,21.5,2z M21,10h-7V3h7V10z"/></svg>
									<span class="sidemenu-label">Dashboard</span>
									<i class="angle fe fe-chevron-right"></i>
								</a>
							</li>
							<li class="nav-item">
								<a class="nav-link with-sub" href="javascript:;">
									<svg class="sidemenu-icon menu-icon" viewBox="0 0 24 24">
										<path fill="#f7f7f7" d="M21 3H3C1.9 3 1 3.9 1 5V19C1 20.1 1.9 21 3 21H21C22.1 21 23 20.1 23 19V5C23 3.9 22.1 3 21 3M21 19H3V5H21M5 7H9C9.6 7 10 7.4 10 8V16C10 16.6 9.6 17 9 17H5C4.4 17 4 16.6 4 16V8C4 7.4 4.4 7 5 7M6 9V15H8V9M15 7H19C19.6 7 20 7.4 20 8V16C20 16.6 19.6 17 19 17H15C14.4 17 14 16.6 14 16V8C14 7.4 14.4 7 15 7M16 9V15H18V9M12 11C12.6 11 13 10.6 13 10C13 9.4 12.6 9 12 9C11.4 9 11 9.4 11 10C11 10.6 11.4 11 12 11M12 15C12.6 15 13 14.6 13 14C13 13.4 12.6 13 12 13C11.4 13 11 13.4 11 14C11 14.6 11.4 15 12 15Z" />
									</svg>
									<span class="sidemenu-label">Pre Match</span>
									<i class="angle fe fe-chevron-right"></i>
								</a>
								<ul class="nav-sub">
									<% getGames %>
								</ul>
								
							</li>

							<!-- <li class="nav-header"><span class="nav-label">Applications</span></li>
							<li class="nav-item">
								<a class="nav-link with-sub" href="javascript:;">
									<svg class="sidemenu-icon menu-icon" xmlns="http://www.w3.org/2000/svg" enable-background="new 0 0 24 24" viewBox="0 0 24 24"><path d="M21.5,13h-8.0005493C13.2234497,13.0001831,12.9998169,13.223999,13,13.5v8.0005493C13.0001831,21.7765503,13.223999,22.0001831,13.5,22h8.0006104C21.7765503,21.9998169,22.0001831,21.776001,22,21.5v-8.0006104C21.9998169,13.2234497,21.776001,12.9998169,21.5,13z M21,21h-7v-7h7V21z M10.5,2H2.4993896C2.2234497,2.0001831,1.9998169,2.223999,2,2.5v8.0005493C2.0001831,10.7765503,2.223999,11.0001831,2.5,11h8.0006104C10.7765503,10.9998169,11.0001831,10.776001,11,10.5V2.4993896C10.9998169,2.2234497,10.776001,1.9998169,10.5,2z M10,10H3V3h7V10z M10.5,13H2.4993896C2.2234497,13.0001831,1.9998169,13.223999,2,13.5v8.0005493C2.0001831,21.7765503,2.223999,22.0001831,2.5,22h8.0006104C10.7765503,21.9998169,11.0001831,21.776001,11,21.5v-8.0006104C10.9998169,13.2234497,10.776001,12.9998169,10.5,13z M10,21H3v-7h7V21z M21.5,2h-8.0005493C13.2234497,2.0001831,12.9998169,2.223999,13,2.5v8.0005493C13.0001831,10.7765503,13.223999,11.0001831,13.5,11h8.0006104C21.7765503,10.9998169,22.0001831,10.776001,22,10.5V2.4993896C21.9998169,2.2234497,21.776001,1.9998169,21.5,2z M21,10h-7V3h7V10z"/></svg>
									<span class="sidemenu-label">Apps</span>
									<i class="angle fe fe-chevron-right"></i>
								</a>
							</li> -->
						</ul>
						<div class="slide-right" id="slide-right"><svg xmlns="http://www.w3.org/2000/svg" fill="#c9bebe" width="24" height="24" viewBox="0 0 24 24"><path d="M10.707 17.707 16.414 12l-5.707-5.707-1.414 1.414L13.586 12l-4.293 4.293z"/></svg></div>
					</div>
				</div>
			</div>
		</div>
		<!-- End Sidemenu -->

		<!-- Main Content-->
		<div class="main-content side-content pt-0">
			<div class="main-container container-fluid">
				<div class="inner-body">

					<!-- Page Header -->
					<div class="page-header">
						<div>
							<h2 class="main-content-title tx-24 mg-b-5">PRE Match</h2>
							<ol class="breadcrumb">
								<li class="breadcrumb-item"><a href="javascript:;">Pages</a></li>
								<li class="breadcrumb-item active" aria-current="page">PRE Match</li>
							</ol>
						</div>
						<!--<div class="d-flex">
							<div class="justify-content-center">
								<button type="button" class="btn btn-white btn-icon-text my-2 me-2">
									<i class="fe fe-settings"></i>
									<span>Settings</span>
								</button>
								<button type="button" class="btn btn-primary my-2 btn-icon-text">
									<i class="fe fe-download-cloud bg-white-transparent text-white"></i>
									<span>Reports</span>
								</button>
							</div>
						</div>-->
					</div>
					<!-- End Page Header -->

					<!-- Row -->
					<div class="row row-sm">
						<div class="col-md-12 col-xl-8 col-xs-12 col-sm-12">
							<div class="card custom-card">
								<div class="card-body">
									<div class="accordion" id="accordionOdds">
										<% 
										if fixtureID <> "" then
											getProps fixtureID
										end if
										%>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-12 col-xl-4 col-xs-12 col-sm-12 betSlip">

						</div>
					</div>
					<!-- End Row -->

				</div>
			</div>
		</div>
		<!-- End Main Content-->

		<!-- Main Footer-->
		<div class="main-footer text-center">
			<div class="container">
				<div class="row row-sm">
					<div class="col-md-12">
						<span>Copyright © 2022 <a href="javascript:void(0);">PRE Match</a>. All rights reserved.</span>
					</div>
				</div>
			</div>
		</div>
		<!--End Footer-->

		<!-- Sidebar -->
		<div class="sidebar sidebar-right sidebar-animate">
			<div class="sidebar-icon">
				<a href="javascript:;" class="text-white fs-18 mt-1 d-block" data-bs-toggle="sidebar-right" data-bs-target=".sidebar-right"><i class="fe fe-x"></i></a>
			</div>
			<div class="sidebar-body">
				<h5 class="text-white">Settings</h5>
				<div class="d-flex p-2">
					<span class="custom-switch-description"> </span>
					<label class="custom-switch ms-auto">
						<input type="checkbox" name="custom-switch-checkbox" class="custom-switch-input" checked>
						<span class="custom-switch-indicator"></span>
					</label>
				</div>
			</div>
		</div>
		<!-- End Sidebar -->

		<!-- Country-selector modal-->
		<div class="modal fade" id="country-selector">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header border-bottom">
						<h6 class="modal-title">Choose Country</h6><button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"></button>
					</div>
					<div class="modal-body">
						<ul class="row p-3">
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block active">
									<span class="country-selector"><img alt="" src="assets/img/flags/us_flag.jpg" class="me-3 language"></span>Usa
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/italy_flag.jpg" class="me-3 language"></span>Italy
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/spain_flag.jpg" class="me-3 language"></span>Spain
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/india_flag.jpg" class="me-3 language"></span>India
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/french_flag.jpg" class="me-3 language"></span>France
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/mexico_flag.jpg" class="me-3 language"></span>Mexico
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/poland_flag.jpg" class="me-3 language"></span>Poland
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/austria_flag.jpg" class="me-3 language"></span>Austria
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/russia_flag.jpg" class="me-3 language"></span>Russia
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/germany_flag.jpg" class="me-3 language"></span>Germany
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/argentina_flag.jpg" class="me-3 language"></span>Argentina
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/uae_flag.jpg" class="me-3 language"></span>U.A.E
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/malaysia_flag.jpg" class="me-3 language"></span>Malaysia
								</a>
							</li>
							<li class="col-lg-6 mb-2">
								<a href="#" class="btn btn-country btn-lg btn-block">
									<span class="country-selector"><img alt="" src="assets/img/flags/canada_flag.jpg" class="me-3 language"></span>Canada
								</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<!-- Country-selector modal-->

	</div>
	<!-- End Page -->

	<!-- Back-to-top -->
	<a href="#top" id="back-to-top"><i class="fe fe-arrow-up"></i></a>
	<script src="assets/plugins/jquery/jquery.min.js"></script>
	<script src="assets/plugins/bootstrap/js/popper.min.js"></script>
	<script src="assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<script src="assets/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
	<script src="assets/plugins/perfect-scrollbar/pscroll1.js"></script>
	<script src="assets/plugins/sidemenu/sidemenu.js"></script>
	<script src="assets/plugins/sidebar/sidebar.js"></script>
	<script src="assets/plugins/select2/js/select2.min.js"></script>
	<script src="assets/js/themeColors.js"></script>
	<script src="assets/js/sticky.js"></script>
	<script src="assets/js/custom1.js"></script>
	<script>
			$('.owl-carousel').owlCarousel({
				loop:true,
				margin:10,
				responsiveClass:true,
				responsive:{
					0:{
						items:4,
						nav:true
					},
					600:{
						items:6,
						nav:false
					},
					1000:{
						items:18,
						nav:false,
						loop:false
					}
				}
			})
            function loadGame(fixtureID){
                window.location.href = "index.asp?fid="+fixtureID;
            }
			
			function getPropsLines(fixtureID,marketID){
				$.get( "index.asp", { action: 'getPropsLines', fid: fixtureID, mid : marketID }, function( data ) {
					$("#p_"+fixtureID+"_"+marketID).html( data );
					//alert(data);
				});
			}
		</script>

</body>
</html>
<% 
	end if
	
	if action = "getPropsLines" then
		marketID = Request.QueryString("mid")
		getPropsLines fixtureID,marketID
	end if
%>

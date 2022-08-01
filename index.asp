<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<% Response.CacheControl = "no-cache" %>
<!--#include file = "inc/common.asp"-->
<!--#include file = "inc/db.asp"-->
<%
	action = Request.QueryString("action")
    fixtureID = Request.QueryString("fid")
	
	if action = "" then
%>
<!doctype html>
<html lang="en" dir="ltr">
	<head>

		<meta charset="UTF-8">
		<meta name='viewport' content='width=device-width, initial-scale=1.0, user-scalable=0'>
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="Description" content="">
		<title> Props Betting </title>
		<link rel="icon" href="backend/img/brand/favicon.png" type="image/x-icon"/>
		<link href="backend/css/icons.css" rel="stylesheet">
		<link href="backend/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
		<link href="backend/plugins/owlcarousel2/assets/owl.carousel.css" rel="stylesheet" />
		<link href="backend/plugins/owlcarousel2/assets/owl.theme.default.css" rel="stylesheet" />
		<link href="backend/css/style.css" rel="stylesheet">
		<link href="backend/css/style-dark.css" rel="stylesheet">
		<link href="backend/css/style-transparent.css" rel="stylesheet">
		<link href="backend/css/skin-modes.css" rel="stylesheet" />
		<link href="backend/css/animate.css" rel="stylesheet">
		<link href="backend/css/custom.css" rel="stylesheet">

	</head>

	<body class="main-body app sidebar-mini ltr">

		<!-- Loader -->
		<div id="global-loader">
			<img src="backend/img/loader.svg" class="loader-img" alt="Loader">
		</div>
		<!-- /Loader -->

		<!-- Page -->
		<div class="page">

			<div>
				<!-- main-header -->
				<div class="main-header side-header sticky nav nav-item">
					<div class=" main-container container-fluid">
						<div class="main-header-left ">
							<div class="responsive-logo">
								<a href="index.html" class="header-logo">
									<img src="backend/img/brand/logo.png" class="mobile-logo logo-1" alt="logo">
									<img src="backend/img/brand/logo-white.png" class="mobile-logo dark-logo-1" alt="logo">
								</a>
							</div>
							<div class="app-sidebar__toggle" data-bs-toggle="sidebar">
								<a class="open-toggle" href="javascript:void(0);"><i class="header-icon fe fe-align-left" ></i></a>
								<a class="close-toggle" href="javascript:void(0);"><i class="header-icon fe fe-x"></i></a>
							</div>
							<div class="logo-horizontal">
								<a href="index.html" class="header-logo">
									<img src="backend/img/brand/logo.png" class="mobile-logo logo-1" alt="logo">
									<img src="backend/img/brand/logo-white.png" class="mobile-logo dark-logo-1" alt="logo">
								</a>
							</div>
							<div class="main-header-center ms-4 d-sm-none d-md-none d-lg-block form-group">
								<input class="form-control" placeholder="Search..." type="search">
								<button class="btn"><i class="fas fa-search"></i></button>
							</div>
						</div>
						<div class="main-header-right">
							<button class="navbar-toggler navresponsive-toggler d-lg-none ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent-4" aria-controls="navbarSupportedContent-4" aria-expanded="false" aria-label="Toggle navigation">
								<span class="navbar-toggler-icon fe fe-more-vertical "></span>
							</button>
							<div class="mb-0 navbar navbar-expand-lg navbar-nav-right responsive-navbar navbar-dark p-0">
								<div class="collapse navbar-collapse" id="navbarSupportedContent-4">
									<ul class="nav nav-item header-icons navbar-nav-right ms-auto">
										<li class="dropdown nav-item">
											<a class="new nav-link" data-bs-target="#country-selector" data-bs-toggle="modal" href=""><svg class="header-icon-svgs" xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path d="M12 2C6.486 2 2 6.486 2 12s4.486 10 10 10 10-4.486 10-10S17.514 2 12 2zm7.931 9h-2.764a14.67 14.67 0 0 0-1.792-6.243A8.013 8.013 0 0 1 19.931 11zM12.53 4.027c1.035 1.364 2.427 3.78 2.627 6.973H9.03c.139-2.596.994-5.028 2.451-6.974.172-.01.344-.026.519-.026.179 0 .354.016.53.027zm-3.842.7C7.704 6.618 7.136 8.762 7.03 11H4.069a8.013 8.013 0 0 1 4.619-6.273zM4.069 13h2.974c.136 2.379.665 4.478 1.556 6.23A8.01 8.01 0 0 1 4.069 13zm7.381 6.973C10.049 18.275 9.222 15.896 9.041 13h6.113c-.208 2.773-1.117 5.196-2.603 6.972-.182.012-.364.028-.551.028-.186 0-.367-.016-.55-.027zm4.011-.772c.955-1.794 1.538-3.901 1.691-6.201h2.778a8.005 8.005 0 0 1-4.469 6.201z"/></svg></a>
										</li>
										<li class="dropdown nav-item">
											<a class="new nav-link theme-layout nav-link-bg layout-setting" >
												<span class="dark-layout"><svg xmlns="http://www.w3.org/2000/svg" class="header-icon-svgs" width="24" height="24" viewBox="0 0 24 24"><path d="M20.742 13.045a8.088 8.088 0 0 1-2.077.271c-2.135 0-4.14-.83-5.646-2.336a8.025 8.025 0 0 1-2.064-7.723A1 1 0 0 0 9.73 2.034a10.014 10.014 0 0 0-4.489 2.582c-3.898 3.898-3.898 10.243 0 14.143a9.937 9.937 0 0 0 7.072 2.93 9.93 9.93 0 0 0 7.07-2.929 10.007 10.007 0 0 0 2.583-4.491 1.001 1.001 0 0 0-1.224-1.224zm-2.772 4.301a7.947 7.947 0 0 1-5.656 2.343 7.953 7.953 0 0 1-5.658-2.344c-3.118-3.119-3.118-8.195 0-11.314a7.923 7.923 0 0 1 2.06-1.483 10.027 10.027 0 0 0 2.89 7.848 9.972 9.972 0 0 0 7.848 2.891 8.036 8.036 0 0 1-1.484 2.059z"/></svg></span>
												<span class="light-layout"><svg xmlns="http://www.w3.org/2000/svg" class="header-icon-svgs" width="24" height="24" viewBox="0 0 24 24"><path d="M6.993 12c0 2.761 2.246 5.007 5.007 5.007s5.007-2.246 5.007-5.007S14.761 6.993 12 6.993 6.993 9.239 6.993 12zM12 8.993c1.658 0 3.007 1.349 3.007 3.007S13.658 15.007 12 15.007 8.993 13.658 8.993 12 10.342 8.993 12 8.993zM10.998 19h2v3h-2zm0-17h2v3h-2zm-9 9h3v2h-3zm17 0h3v2h-3zM4.219 18.363l2.12-2.122 1.415 1.414-2.12 2.122zM16.24 6.344l2.122-2.122 1.414 1.414-2.122 2.122zM6.342 7.759 4.22 5.637l1.415-1.414 2.12 2.122zm13.434 10.605-1.414 1.414-2.122-2.122 1.414-1.414z"/></svg></span>
											</a>
										</li>
										<li class="nav-item full-screen fullscreen-button">
											<a class="new nav-link full-screen-link" href="javascript:void(0);"><svg xmlns="http://www.w3.org/2000/svg" class="header-icon-svgs" width="24" height="24" viewBox="0 0 24 24"><path d="M5 5h5V3H3v7h2zm5 14H5v-5H3v7h7zm11-5h-2v5h-5v2h7zm-2-4h2V3h-7v2h5z"/></svg></a>
										</li>
										<li class="dropdown main-header-message right-toggle">
											<a class="new nav-link nav-link pe-0" data-bs-toggle="sidebar-right" data-bs-target=".sidebar-right">
												<svg xmlns="http://www.w3.org/2000/svg" class="header-icon-svgs" width="24" height="24" viewBox="0 0 24 24"><path d="M4 6h16v2H4zm4 5h12v2H8zm5 5h7v2h-7z"/></svg>
											</a>
										</li>
										<li class="nav-link search-icon d-lg-none d-block">
											<form class="navbar-form" role="search">
												<div class="input-group">
													<input type="text" class="form-control" placeholder="Search">
													<span class="input-group-btn">
														<button type="reset" class="btn btn-default">
															<i class="fas fa-times"></i>
														</button>
														<button type="submit" class="btn btn-default nav-link resp-btn">
															<svg xmlns="http://www.w3.org/2000/svg" height="24px" class="header-icon-svgs" viewBox="0 0 24 24" width="24px" fill="#000000"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M15.5 14h-.79l-.28-.27C15.41 12.59 16 11.11 16 9.5 16 5.91 13.09 3 9.5 3S3 5.91 3 9.5 5.91 16 9.5 16c1.61 0 3.09-.59 4.23-1.57l.27.28v.79l5 4.99L20.49 19l-4.99-5zm-6 0C7.01 14 5 11.99 5 9.5S7.01 5 9.5 5 14 7.01 14 9.5 11.99 14 9.5 14z"/></svg>
														</button>
													</span>
												</div>
											</form>
										</li>
										<li class="dropdown main-profile-menu nav nav-item nav-link ps-lg-2">
											<a class="new nav-link profile-user d-flex" href="" data-bs-toggle="dropdown"><img alt="" src="backend/img/faces/2.jpg" class=""></a>
											<div class="dropdown-menu">
												<div class="menu-header-content p-3 border-bottom">
													<div class="d-flex wd-100p">
														<div class="main-img-user"><img alt="" src="backend/img/faces/2.jpg" class=""></div>
														<div class="ms-3 my-auto">
															<h6 class="tx-15 font-weight-semibold mb-0">Teri Dactyl</h6><span class="dropdown-title-text subtext op-6  tx-12">Premium Member</span>
														</div>
													</div>
												</div>
												<a class="dropdown-item" href="profile.html"><i class="far fa-user-circle"></i>Profile</a>
												<a class="dropdown-item" href="chat.html"><i class="far fa-smile"></i> chat</a>
												<a class="dropdown-item" href="mail-read.html"><i class="far fa-envelope "></i>Inbox</a>
												<a class="dropdown-item" href="mail.html"><i class="far fa-comment-dots"></i>Messages</a>
												<a class="dropdown-item" href="mail-settings.html"><i class="far fa-sun"></i>  Settings</a>
												<a class="dropdown-item" href="signup.html"><i class="far fa-arrow-alt-circle-left"></i> Sign Out</a>
											</div>
										</li>
									</ul>
								</div>
							</div>
							<div class="d-flex">
								
							</div>
						</div>
					</div>
				</div>
				<!-- /main-header -->

				<!-- main-sidebar -->
				<div class="sticky">
					<aside class="app-sidebar">
						<div class="main-sidebar-header active">
							<a class="header-logo active" href="index.html">
								<img src="backend/img/brand/logo.png" class="main-logo  desktop-logo" alt="logo">
								<img src="backend/img/brand/logo-white.png" class="main-logo  desktop-dark" alt="logo">
								<img src="backend/img/brand/favicon.png" class="main-logo  mobile-logo" alt="logo">
								<img src="backend/img/brand/favicon-white.png" class="main-logo  mobile-dark" alt="logo">
							</a>
						</div>
						<div class="main-sidemenu">
							<div class="slide-left disabled" id="slide-left"><svg xmlns="http://www.w3.org/2000/svg" fill="#7b8191" width="24" height="24" viewBox="0 0 24 24"><path d="M13.293 6.293 7.586 12l5.707 5.707 1.414-1.414L10.414 12l4.293-4.293z"/></svg></div>
							<ul class="side-menu">
								<li class="side-item side-item-category">Main</li>
								<li class="slide"><a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0);"> <i class="fe fe-home me-1"></i></i><span class="side-menu__label"> Live Betting</span></a></li>
								<li class="slide"><a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0);"> <i class="fe fe-calendar me-1"></i><span class="side-menu__label"> Today's Games</span></a></li>
								<li class="slide"><a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0);"> <i class="fe fe-list me-1"></i><span class="side-menu__label"> Results</span></a></li>
								<li class="slide"><a class="side-menu__item" data-bs-toggle="slide" href="javascript:void(0);"> <i class="fe fe-check-square me-1"></i><span class="side-menu__label"> Rules</span></a></li>
							</ul>
							<div class="slide-right" id="slide-right"><svg xmlns="http://www.w3.org/2000/svg" fill="#7b8191" width="24" height="24" viewBox="0 0 24 24"><path d="M10.707 17.707 16.414 12l-5.707-5.707-1.414 1.414L13.586 12l-4.293 4.293z"/></svg></div>
						</div>
					</aside>
				</div>
				<!-- main-sidebar -->
			</div>

			<!-- main-content -->
			<div class="main-content app-content">

				<!-- container -->
				<div class="main-container container-fluid">

					<!-- breadcrumb -->
					<div class="breadcrumb-header justify-content-between">
						<div class="left-content">
						  <span class="main-content-title mg-b-0 mg-b-lg-1"> </span>
						</div>
						<div class="justify-content-center mt-2">
							
						</div>
					</div>
					<!-- /breadcrumb -->

					<!-- row -->
					<div class="bet_option_sidebar">
						<div class="row">
							<div class="col-md-2 col-xl-2 col-xs-12 col-sm-12">
								<div class="card custom-card">
									<div class="card-header d-flex custom-card-header border-bottom-0 bd-0 tx-dark bg-gray-200 p-2">
										<h5 class="card-title"><i class="cIcons-sm baseball-sm"></i>Baseball</h5>
										<div class="card-options">
											<a href="javascript:void(0);" class="card-options-collapse" data-bs-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a>
										</div>
									</div>
									<div class="card-body p-1">
										<% getGames %>
									</div>
								</div>
							</div>
							<div class="col-md-7 col-xl-7 col-xs-12 col-sm-12 sportsOdds">
								<div class="card">
									<div class="card-header d-flex custom-card-header border-bottom-0 bd-0 tx-dark bg-gray-200 p-2">
										<h5 class="card-title">Description</h5>
										<div class="card-options">
											<a href="javascript:void(0);" class="card-options-collapse" data-bs-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a>
										</div>
									</div>
									<div class="card-body p-1">
										<div class="row">
											<div class="col">
												<div class="accordion" id="accordionExample">
													<% 
													if fixtureID <> "" then
														getProps fixtureID
													end if
													%>
												</div>  
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="col-md-3 col-xl-3 col-xs-12 col-sm-12">
								<div class="card">
									<div class="card-header d-flex custom-card-header border-bottom-0 bd-0 tx-dark bg-gray-200 p-2">
										<h5 class="card-title">Bet Slip</h5>
										<div class="card-options">
											<a href="javascript:void(0);" class="card-options-collapse" data-bs-toggle="card-collapse"><i class="fe fe-chevron-up"></i></a>
										</div>
									</div>
									<div class="card-body p-1">
										<div>
											<p><i class="fe fe-alert-octagon text-primary fs-6"></i> No bets selected!<br> Please browse our sportsbook and select bets by tapping on the odds</p>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- row closed -->
				</div>
				<!-- Container closed -->
			</div>
			<!-- main-content closed -->

			<!-- Sidebar-right-->
			<div class="sidebar sidebar-right sidebar-animate">
				<div class="panel panel-primary card mb-0 box-shadow">
					<div class="tab-menu-heading card-img-top-1 border-0 p-3">
						<div class="card-title mb-0">Notifications</div>
						<div class="card-options ms-auto">
							<a href="javascript:void(0);" class="sidebar-remove"><i class="fe fe-x"></i></a>
						</div>
					</div>
					<div class="panel-body tabs-menu-body latest-tasks p-0 border-0">
						<div class="tabs-menu ">
							<!-- Tabs -->
							<ul class="nav panel-tabs">
								<li class=""><a href="#side1" class="active" data-bs-toggle="tab"><svg xmlns="http://www.w3.org/2000/svg"  class="side-menu__icon" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M22 6c0-1.1-.9-2-2-2H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6zm-2 0l-8 5-8-5h16zm0 12H4V8l8 5 8-5v10z"/></svg> Chat</a></li>
								<li><a href="#side2" data-bs-toggle="tab"><svg xmlns="http://www.w3.org/2000/svg"  class="side-menu__icon" width="24" height="24" viewBox="0 0 24 24"><path d="M10 3H4a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1zM9 9H5V5h4v4zm11-6h-6a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1zm-1 6h-4V5h4v4zm-9 4H4a1 1 0 0 0-1 1v6a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1v-6a1 1 0 0 0-1-1zm-1 6H5v-4h4v4zm8-6c-2.206 0-4 1.794-4 4s1.794 4 4 4 4-1.794 4-4-1.794-4-4-4zm0 6c-1.103 0-2-.897-2-2s.897-2 2-2 2 .897 2 2-.897 2-2 2z"/></svg> Notifications</a></li>
								<li><a href="#side3" data-bs-toggle="tab"><svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink"  class="side-menu__icon"  height="24" version="1.1" width="24"  viewBox="0 0 24 24"><path d="M12,2C6.48,2 2,6.48 2,12C2,17.52 6.48,22 12,22C17.52,22 22,17.52 22,12C22,6.48 17.52,2 12,2M7.07,18.28C7.5,17.38 10.12,16.5 12,16.5C13.88,16.5 16.5,17.38 16.93,18.28C15.57,19.36 13.86,20 12,20C10.14,20 8.43,19.36 7.07,18.28M18.36,16.83C16.93,15.09 13.46,14.5 12,14.5C10.54,14.5 7.07,15.09 5.64,16.83C4.62,15.5 4,13.82 4,12C4,7.59 7.59,4 12,4C16.41,4 20,7.59 20,12C20,13.82 19.38,15.5 18.36,16.83M12,6C10.06,6 8.5,7.56 8.5,9.5C8.5,11.44 10.06,13 12,13C13.94,13 15.5,11.44 15.5,9.5C15.5,7.56 13.94,6 12,6M12,11C11.17,11 10.5,10.33 10.5,9.5C10.5,8.67 11.17,8 12,8C12.83,8 13.5,8.67 13.5,9.5C13.5,10.33 12.83,11 12,11Z" /></svg> Friends</a></li>
						</ul>
						</div>
						<div class="tab-content">
							<div class="tab-pane active " id="side1">
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-primary brround avatar-md">CH</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>New Websites is Created</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">30 mins ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-danger brround avatar-md">N</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Prepare For the Next Project</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">2 hours ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-info brround avatar-md">S</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Decide the live Discussion</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">3 hours ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-warning brround avatar-md">K</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Meeting at 3:00 pm</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">4 hours ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-success brround avatar-md">R</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Prepare for Presentation</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">1 days ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-pink brround avatar-md">MS</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Prepare for Presentation</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">1 days ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center border-bottom p-3">
									<div class="">
										<span class="avatar bg-purple brround avatar-md">L</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Prepare for Presentation</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">45 mintues ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
								<div class="list d-flex align-items-center p-3">
									<div class="">
										<span class="avatar bg-blue brround avatar-md">U</span>
									</div>
									<a class="wrapper w-100 ms-3" href="javascript:void(0);" >
										<p class="mb-0 d-flex ">
											<b>Prepare for Presentation</b>
										</p>
										<div class="d-flex justify-content-between align-items-center">
											<div class="d-flex align-items-center">
												<i class="mdi mdi-clock text-muted me-1 tx-11"></i>
												<small class="text-muted ms-auto">2 days ago</small>
												<p class="mb-0"></p>
											</div>
										</div>
									</a>
								</div>
							</div>
							<div class="tab-pane  " id="side2">
								<div class="list-group list-group-flush ">
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/12.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div>
											<strong>Madeleine</strong> Hey! there I' am available....
											<div class="small text-muted">
												3 hours ago
											</div>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/1.jpg"></span>
										</div>
										<div>
											<strong>Anthony</strong> New product Launching...
											<div class="small text-muted">
												5 hour ago
											</div>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/2.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div>
											<strong>Olivia</strong> New Schedule Realease......
											<div class="small text-muted">
												45 mintues ago
											</div>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/8.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div>
											<strong>Madeleine</strong> Hey! there I' am available....
											<div class="small text-muted">
												3 hours ago
											</div>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/11.jpg"></span>
										</div>
										<div>
											<strong>Anthony</strong> New product Launching...
											<div class="small text-muted">
												5 hour ago
											</div>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/6.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div>
											<strong>Olivia</strong> New Schedule Realease......
											<div class="small text-muted">
												45 mintues ago
											</div>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-3">
											<span class="avatar avatar-lg brround cover-image" data-image-src="backend/img/faces/9.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div>
											<strong>Olivia</strong> Hey! there I' am available....
											<div class="small text-muted">
												12 mintues ago
											</div>
										</div>
									</div>
								</div>
							</div>
							<div class="tab-pane  " id="side3">
								<div class="list-group list-group-flush ">
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/9.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Mozelle Belt</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/11.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Florinda Carasco</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel" ><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/10.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Alina Bernier</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/2.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Zula Mclaughin</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/13.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Isidro Heide</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/12.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Mozelle Belt</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" ><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/4.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Florinda Carasco</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/7.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Alina Bernier</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" ><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/2.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Zula Mclaughin</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel" ><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/14.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Isidro Heide</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" ><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/11.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Florinda Carasco</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/9.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Alina Bernier</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/15.jpg"><span class="avatar-status bg-success"></span></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Zula Mclaughin</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
									<div class="list-group-item d-flex  align-items-center">
										<div class="me-2">
											<span class="avatar avatar-md brround cover-image" data-image-src="backend/img/faces/4.jpg"></span>
										</div>
										<div class="">
											<div class="font-weight-semibold" data-bs-toggle="modal" data-bs-target="#chatmodel">Isidro Heide</div>
										</div>
										<div class="ms-auto">
											<a href="javascript:void(0);" class="btn btn-sm btn-outline-light btn-rounded" data-bs-toggle="modal" data-bs-target="#chatmodel"><i class="mdi mdi-message-outline"></i></a>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--/Sidebar-right-->

			<!-- Country-selector modal-->
			<div class="modal fade" id="country-selector">
				<div class="modal-dialog modal-dialog-centered" role="document">
					<div class="modal-content">
						<div class="modal-header border-bottom">
							<h6 class="modal-title">Choose Country</h6><button aria-label="Close" class="btn-close" data-bs-dismiss="modal" type="button"><span aria-hidden="true">×</span></button>
						</div>
						<div class="modal-body">
							<ul class="row p-3">
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block active">
										<span class="country-selector"><img alt="" src="backend/img/flags/us_flag.jpg" class="me-3 language"></span>Usa
									</a>
								</li>
								<li class="col-lg-6 mb-2 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/italy_flag.jpg" class="me-3 language"></span>Italy
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/spain_flag.jpg" class="me-3 language"></span>Spain
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/india_flag.jpg" class="me-3 language"></span>India
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/french_flag.jpg" class="me-3 language"></span>France
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/mexico.jpg" class="me-3 language"></span>Mexico
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/singapore.jpg" class="me-3 language"></span>Singapore
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/poland.jpg" class="me-3 language"></span>Poland
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/austria.jpg" class="me-3 language"></span>Austria
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/russia_flag.jpg" class="me-3 language"></span>Russia
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/germany_flag.jpg" class="me-3 language"></span>Germany
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/argentina.jpg" class="me-3 language"></span>Argentina
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/brazil.jpg" class="me-3 language"></span>Brazil
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/uae.jpg" class="me-3 language"></span>U.A.E
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/china.jpg" class="me-3 language"></span>China
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/uk.jpg" class="me-3 language"></span>U.K
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/malaysia.jpg" class="me-3 language"></span>Malaysia
									</a>
								</li>
								<li class="col-lg-6 mb-2">
									<a href="#" class="btn btn-country btn-lg btn-block">
										<span class="country-selector"><img alt="" src="backend/img/flags/canada.jpg" class="me-3 language"></span>Canada
									</a>
								</li>
							</ul>
						</div>
					</div>
				</div>
			</div>
			<!-- Country-selector modal-->

			<!-- Message Modal -->
			<div class="modal fade" id="chatmodel" tabindex="-1" role="dialog"  aria-hidden="true">
				<div class="modal-dialog modal-dialog-right chatbox" role="document">
					<div class="modal-content chat border-0">
						<div class="card overflow-hidden mb-0 border-0">
							<!-- action-header -->
							<div class="action-header clearfix">
								<div class="float-start hidden-xs d-flex ms-2">
									<div class="img_cont me-3">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img" alt="img">
									</div>
									<div class="align-items-center mt-0">
										<h4 class="text-white mb-0 font-weight-semibold">Daneil Scott</h4>
										<span class="dot-label bg-success"></span><span class="me-3 text-white">online</span>
									</div>
								</div>
								<ul class="ah-actions actions align-items-center">
									<li class="call-icon">
										<a href="" class="d-done d-md-block phone-button" data-bs-toggle="modal" data-bs-target="#audiomodal">
											<i class="fe fe-phone"></i>
										</a>
									</li>
									<li class="video-icon">
										<a href="" class="d-done d-md-block phone-button" data-bs-toggle="modal" data-bs-target="#videomodal">
											<i class="fe fe-video"></i>
										</a>
									</li>
									<li class="dropdown">
										<a href="" data-bs-toggle="dropdown" aria-expanded="true">
											<i class="fe fe-more-vertical"></i>
										</a>
										<ul class="dropdown-menu dropdown-menu-end">
											<li><i class="fa fa-user-circle"></i> View profile</li>
											<li><i class="fa fa-users"></i>Add friends</li>
											<li><i class="fa fa-plus"></i> Add to group</li>
											<li><i class="fa fa-ban"></i> Block</li>
									</ul>
									</li>
									<li>
										<a href=""  class="" data-bs-dismiss="modal" aria-label="Close">
											<span aria-hidden="true"><i class="fe fe-x-circle text-white"></i></span>
										</a>
									</li>
							</ul>
							</div>
							<!-- action-header end -->

							<!-- msg_card_body -->
							<div class="card-body msg_card_body">
								<div class="chat-box-single-line">
									<abbr class="timestamp">july 1st, 2021</abbr>
								</div>
								<div class="d-flex justify-content-start">
									<div class="img_cont_msg">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
									<div class="msg_cotainer">
										Hi, how are you Jenna Side?
										<span class="msg_time">8:40 AM, Today</span>
									</div>
								</div>
								<div class="d-flex justify-content-end ">
									<div class="msg_cotainer_send">
										Hi Connor Paige i am good tnx how about you?
										<span class="msg_time_send">8:55 AM, Today</span>
									</div>
									<div class="img_cont_msg">
										<img src="backend/img/faces/9.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
								</div>
								<div class="d-flex justify-content-start ">
									<div class="img_cont_msg">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
									<div class="msg_cotainer">
										I am good too, thank you for your chat template
										<span class="msg_time">9:00 AM, Today</span>
									</div>
								</div>
								<div class="d-flex justify-content-end ">
									<div class="msg_cotainer_send">
										You welcome Connor Paige
										<span class="msg_time_send">9:05 AM, Today</span>
									</div>
									<div class="img_cont_msg">
										<img src="backend/img/faces/9.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
								</div>
								<div class="d-flex justify-content-start ">
									<div class="img_cont_msg">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
									<div class="msg_cotainer">
										Yo, Can you update Views?
										<span class="msg_time">9:07 AM, Today</span>
									</div>
								</div>
								<div class="d-flex justify-content-end mb-4">
									<div class="msg_cotainer_send">
										But I must explain to you how all this mistaken  born and I will give
										<span class="msg_time_send">9:10 AM, Today</span>
									</div>
									<div class="img_cont_msg">
										<img src="backend/img/faces/9.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
								</div>
								<div class="d-flex justify-content-start ">
									<div class="img_cont_msg">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
									<div class="msg_cotainer">
										Yo, Can you update Views?
										<span class="msg_time">9:07 AM, Today</span>
									</div>
								</div>
								<div class="d-flex justify-content-end mb-4">
									<div class="msg_cotainer_send">
										But I must explain to you how all this mistaken  born and I will give
										<span class="msg_time_send">9:10 AM, Today</span>
									</div>
									<div class="img_cont_msg">
										<img src="backend/img/faces/9.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
								</div>
								<div class="d-flex justify-content-start ">
									<div class="img_cont_msg">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
									<div class="msg_cotainer">
										Yo, Can you update Views?
										<span class="msg_time">9:07 AM, Today</span>
									</div>
								</div>
								<div class="d-flex justify-content-end mb-4">
									<div class="msg_cotainer_send">
										But I must explain to you how all this mistaken  born and I will give
										<span class="msg_time_send">9:10 AM, Today</span>
									</div>
									<div class="img_cont_msg">
										<img src="backend/img/faces/9.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
								</div>
								<div class="d-flex justify-content-start">
									<div class="img_cont_msg">
										<img src="backend/img/faces/6.jpg" class="rounded-circle user_img_msg" alt="img">
									</div>
									<div class="msg_cotainer">
										Okay Bye, text you later..
										<span class="msg_time">9:12 AM, Today</span>
									</div>
								</div>
							</div>
							<!-- msg_card_body end -->
							<!-- card-footer -->
							<div class="card-footer">
								<div class="msb-reply d-flex">
									<div class="input-group">
										<input type="text" class="form-control " placeholder="Typing....">
										<div class="input-group-append ">
											<button type="button" class="btn btn-primary ">
												<i class="far fa-paper-plane" aria-hidden="true"></i>
											</button>
										</div>
									</div>
								</div>
							</div><!-- card-footer end -->
						</div>
					</div>
				</div>
			</div>

			<!--Video Modal -->
			<div id="videomodal" class="modal fade">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-body mx-auto text-center p-7">
							<h5>Nowa Video call</h5>
							<img src="backend/img/faces/6.jpg" class="rounded-circle user-img-circle h-8 w-8 mt-4 mb-3" alt="img">
							<h4 class="mb-1 font-weight-semibold">Daneil Scott</h4>
							<h6>Calling...</h6>
							<div class="mt-5">
								<div class="row">
									<div class="col-4">
										<a class="icon icon-shape rounded-circle mb-0 me-3" href="javascript:void(0);">
											<i class="fas fa-video-slash"></i>
										</a>
									</div>
									<div class="col-4">
										<a class="icon icon-shape rounded-circle text-white mb-0 me-3" href="javascript:void(0);" data-bs-dismiss="modal" aria-label="Close">
											<i class="fas fa-phone bg-danger text-white"></i>
										</a>
									</div>
									<div class="col-4">
										<a class="icon icon-shape rounded-circle mb-0 me-3" href="javascript:void(0);">
											<i class="fas fa-microphone-slash"></i>
										</a>
									</div>
								</div>
							</div>
						</div><!-- modal-body -->
					</div>
				</div><!-- modal-dialog -->
			</div><!-- modal -->

			<!-- Audio Modal -->
			<div id="audiomodal" class="modal fade">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-body mx-auto text-center p-7">
							<h5>Nowa Voice call</h5>
							<img src="backend/img/faces/6.jpg" class="rounded-circle user-img-circle h-8 w-8 mt-4 mb-3" alt="img">
							<h4 class="mb-1  font-weight-semibold">Daneil Scott</h4>
							<h6>Calling...</h6>
							<div class="mt-5">
								<div class="row">
									<div class="col-4">
										<a class="icon icon-shape rounded-circle mb-0 me-3" href="javascript:void(0);">
											<i class="fas fa-volume-up bg-light"></i>
										</a>
									</div>
									<div class="col-4">
										<a class="icon icon-shape rounded-circle text-white mb-0 me-3" href="javascript:void(0);" data-bs-dismiss="modal" aria-label="Close">
											<i class="fas fa-phone text-white bg-primary"></i>
										</a>
									</div>
									<div class="col-4">
										<a class="icon icon-shape  rounded-circle mb-0 me-3" href="javascript:void(0);">
											<i class="fas fa-microphone-slash bg-light"></i>
										</a>
									</div>
								</div>
							</div>
						</div><!-- modal-body -->
					</div>
				</div><!-- modal-dialog -->
			</div><!-- modal -->

			<!-- Footer opened -->
			<div class="main-footer">
				<div class="container-fluid pt-0 ht-100p">
					 Copyright © 2022 <a href="javascript:void(0);" class="text-primary">Live Betting</a>. All Rights Reserved
				</div>
			</div>
			<!-- Footer closed -->

		</div>
		<!-- End Page -->

		<!-- Back-to-top -->
		<a href="#top" id="back-to-top"><i class="las la-arrow-up"></i></a>

		<script src="backend/plugins/jquery/jquery.min.js"></script>
		<script src="backend/plugins/bootstrap/js/popper.min.js"></script>
		<script src="backend/plugins/bootstrap/js/bootstrap.min.js"></script>
		<script src="backend/plugins/moment/moment.js"></script>
		<script src="backend/plugins/perfect-scrollbar/perfect-scrollbar.min.js"></script>
		<script src="backend/plugins/perfect-scrollbar/p-scroll.js"></script>
		<script src="backend/js/eva-icons.min.js"></script>
		<script src="backend/plugins/side-menu/sidemenu.js"></script>
		<script src="backend/js/sticky.js"></script>
		<script src="backend/plugins/sidebar/sidebar.js"></script>
		<script src="backend/plugins/sidebar/sidebar-custom.js"></script>
		<script src="backend/plugins/owlcarousel2/owl.carousel.min.js"></script>
		<script src="backend/js/themecolor.js"></script>
		<script src="backend/js/custom.js"></script>
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
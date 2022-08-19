$(function () {
	'use strict'

	// ______________ PAGE LOADING
	$("#global-loader").fadeOut("slow");

	// ______________ Card
	const DIV_CARD = 'div.card';

	// ______________ Function for remove card
	$(document).on('click', '[data-bs-toggle="card-remove"]', function (e) {
		let $card = $(this).closest(DIV_CARD);
		$card.remove();
		e.preventDefault();
		return false;
	});

	// ______________ Functions for collapsed card
	$(document).on('click', '[data-bs-toggle="card-collapse"]', function (e) {
		let $card = $(this).closest(DIV_CARD);
		$card.toggleClass('card-collapsed');
		e.preventDefault();
		return false;
	});

	// ______________ Card full screen
	$(document).on('click', '[data-bs-toggle="card-fullscreen"]', function (e) {
		let $card = $(this).closest(DIV_CARD);
		$card.toggleClass('card-fullscreen').removeClass('card-collapsed');
		e.preventDefault();
		return false;
	});

	// ______________Main-navbar
	if (window.matchMedia('(min-width: 992px)').matches) {
		$('.main-navbar .active').removeClass('show');
		$('.main-header-menu .active').removeClass('show');
	}
	$('.main-header .dropdown > a').on('click', function (e) {
		e.preventDefault();
		$(this).parent().toggleClass('show');
		$(this).parent().siblings().removeClass('show');
	});
	$('.mobile-main-header .dropdown > a').on('click', function (e) {
		e.preventDefault();
		$(this).parent().toggleClass('show');
		$(this).parent().siblings().removeClass('show');
	});
	$('.main-navbar .with-sub').on('click', function (e) {
		e.preventDefault();
		$(this).parent().toggleClass('show');
		$(this).parent().siblings().removeClass('show');
	});
	$('.dropdown-menu .main-header-arrow').on('click', function (e) {
		e.preventDefault();
		$(this).closest('.dropdown').removeClass('show');
	});
	$('#mainSidebarToggle').on('click', function (e) {
		e.preventDefault();
		$('body.horizontalmenu').toggleClass('main-navbar-show');
	});
	$('#mainContentLeftShow').on('click touch', function (e) {
		e.preventDefault();
		$('body').addClass('main-content-left-show');
	});
	$('#mainContentLeftHide').on('click touch', function (e) {
		e.preventDefault();
		$('body').removeClass('main-content-left-show');
	});
	$('#mainContentBodyHide').on('click touch', function (e) {
		e.preventDefault();
		$('body').removeClass('main-content-body-show');
	})
	$('body').append('<div class="main-navbar-backdrop"></div>');
	$('.main-navbar-backdrop').on('click touchstart', function () {
		$('body').removeClass('main-navbar-show');
	});



	// ______________Dropdown menu
	$(document).on('click touchstart', function (e) {
		e.stopPropagation();
		var dropTarg = $(e.target).closest('.main-header .dropdown').length;
		if (!dropTarg) {
			$('.main-header .dropdown').removeClass('show');
		}
		if (window.matchMedia('(min-width: 992px)').matches) {
			var navTarg = $(e.target).closest('.main-navbar .nav-item').length;
			if (!navTarg) {
				$('.main-navbar .show').removeClass('show');
			}
			var menuTarg = $(e.target).closest('.main-header-menu .nav-item').length;
			if (!menuTarg) {
				$('.main-header-menu .show').removeClass('show');
			}
			if ($(e.target).hasClass('main-menu-sub-mega')) {
				$('.main-header-menu .show').removeClass('show');
			}
		} else {
			if (!$(e.target).closest('#mainMenuShow').length) {
				var hm = $(e.target).closest('.main-header-menu').length;
				if (!hm) {
					$('body').removeClass('main-header-menu-show');
				}
			}
		}
	});

	// ______________MainMenuShow
	$('#mainMenuShow').on('click', function (e) {
		e.preventDefault();
		$('body').toggleClass('main-header-menu-show');
	})
	$('.main-header-menu .with-sub').on('click', function (e) {
		e.preventDefault();
		$(this).parent().toggleClass('show');
		$(this).parent().siblings().removeClass('show');
	})
	$('.main-header-menu-header .close').on('click', function (e) {
		e.preventDefault();
		$('body').removeClass('main-header-menu-show');
	})

	// ______________Popover
	var popoverTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="popover"]'))
	var popoverList = popoverTriggerList.map(function (popoverTriggerEl) {
		return new bootstrap.Popover(popoverTriggerEl)
	})

	// ______________Tooltip
	var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
	var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
		return new bootstrap.Tooltip(tooltipTriggerEl)
	})

	// ______________Toast
	$(".toast").toast();

	// ______________Live Toast
	var toastTrigger = document.getElementById('liveToastBtn')
	var toastLiveExample = document.getElementById('liveToast')
	if (toastTrigger) {
		toastTrigger.addEventListener('click', function () {
			var toast = new bootstrap.Toast(toastLiveExample)

			toast.show()
		})
	}

	// ______________Back-top-button
	$(window).on("scroll", function (e) {
		if ($(this).scrollTop() > 0) {
			$('#back-to-top').fadeIn('slow');
		} else {
			$('#back-to-top').fadeOut('slow');
		}
	});
	$(document).on("click", "#back-to-top", function (e) {
		$("html, body").animate({
			scrollTop: 0
		}, 0);
		return false;
	});

	// ______________Full screen
	$(document).on("click", ".fullscreen-button", function toggleFullScreen() {
		$('html').addClass('fullscreen');
		if ((document.fullScreenElement !== undefined && document.fullScreenElement === null) || (document.msFullscreenElement !== undefined && document.msFullscreenElement === null) || (document.mozFullScreen !== undefined && !document.mozFullScreen) || (document.webkitIsFullScreen !== undefined && !document.webkitIsFullScreen)) {
			if (document.documentElement.requestFullScreen) {
				document.documentElement.requestFullScreen();
			} else if (document.documentElement.mozRequestFullScreen) {
				document.documentElement.mozRequestFullScreen();
			} else if (document.documentElement.webkitRequestFullScreen) {
				document.documentElement.webkitRequestFullScreen(Element.ALLOW_KEYBOARD_INPUT);
			} else if (document.documentElement.msRequestFullscreen) {
				document.documentElement.msRequestFullscreen();
			}
		} else {
			$('html').removeClass('fullscreen');
			if (document.cancelFullScreen) {
				document.cancelFullScreen();
			} else if (document.mozCancelFullScreen) {
				document.mozCancelFullScreen();
			} else if (document.webkitCancelFullScreen) {
				document.webkitCancelFullScreen();
			} else if (document.msExitFullscreen) {
				document.msExitFullscreen();
			}
		}
	})

	//Input file-browser
	$(document).on('change', '.file-browserinput', function () {
		var input = $(this),
			numFiles = input.get(0).files ? input.get(0).files.length : 1,
			label = input.val().replace(/\\/g, '/').replace(/.*\//, '');
		input.trigger('fileselect', [numFiles, label]);
	});// We can watch for our custom `fileselect` event like this

	// ______________Cover Image
	$(".cover-image").each(function () {
		var attr = $(this).attr('data-image-src');
		if (typeof attr !== typeof undefined && attr !== false) {
			$(this).css('background', 'url(' + attr + ') center center');
		}
	});

	// ______________Accordion Style
	$(document).on("click", '[data-bs-toggle="collapse"]', function () {
		$(this).toggleClass('active').siblings().removeClass('active');
	});

	// ______________EMAIL INBOX
	$(".clickable-row").on('click', function () {
		window.location = $(this).data("href");
	});

	// ______________Horizontal-menu Active Class
	function addActiveClass(element) {
		if (current === "") {
			if (element.attr('href').indexOf("#") !== -1) {
				element.parents('.main-navbar .nav-item').last().removeClass('active');
				if (element.parents('.main-navbar .nav-sub').length) {
					element.parents('.main-navbar .nav-sub-item').last().removeClass('active');
				}
			}
		} else {
			if (element.attr('href').indexOf(current) !== -1) {
				element.parents('.main-navbar .nav-item').last().addClass('active');
				if (element.parents('.main-navbar .nav-sub').length) {
					element.parents('.main-navbar .nav-sub-item').last().addClass('active');
				}
			}
		}
	}
	var current = location.pathname.split("/").slice(-1)[0].replace(/^\/|\/$/g, '');
	$('.main-navbar .nav li a').each(function () {
		var $this = $(this);
		addActiveClass($this);
	})


	/* Headerfixed */
	$(window).on("scroll", function (e) {
		if ($(window).scrollTop() >= 66) {
			$('.main-header').addClass('fixed-header');
		}
		else {
			$('.main-header').removeClass('fixed-header');
		}
	});


	/*Switcher Toggle Start*/
	$('.layout-setting').on("click", function(e) {
		if (!(document.querySelector('body').classList.contains('dark-theme'))) {
			$('body').addClass('dark-theme');
			$('body').removeClass('light-theme');
			$('body').removeClass('transparent-theme');

            $('#myonoffswitch5').prop('checked', true);
            $('#myonoffswitch8').prop('checked', true);

			localStorage.setItem('darkMode', true);
			localStorage.removeItem('lightMode');
			localStorage.removeItem('transparentMode');
            $('#myonoffswitch2').prop('checked', true);
            
		} else {
			$('body').removeClass('dark-theme');
			$('body').addClass('light-theme');
            $('#myonoffswitch3').prop('checked', true);
            $('#myonoffswitch6').prop('checked', true);

			localStorage.setItem('lightMode', true);
			localStorage.removeItem('transparentMode');
			localStorage.removeItem('darkMode');
            $('#myonoffswitch1').prop('checked', true);
		}
	});
	/*Switcher Toggle End*/

	/* Light Theme Start */
		// $('body').addClass('light-theme');
	/* Light Theme End */

	/* Dark Theme Start */
		// $('body').addClass('dark-theme');
		// $('body').removeClass('light-theme');
	/* Dark Theme End */

	/* Transparent Theme Start */
		// 	$('body').addClass('transparent-theme');
		// 	$('body').removeClass('light-theme');
		// 	$('body').removeClass('dark-menu');
	// /* Transparent Theme End */

	/* Transparent Bg-Image1 Style Start */
		// $('body').addClass('transparent-theme');
		// $('body').addClass('bg-img1');
		// $('body').removeClass('light-theme');
		// $('body').removeClass('dark-menu');
	/* Transparent Bg-Image1 Style End */

	/* Transparent Bg-Image2 Style Start */
		// $('body').addClass('transparent-theme');
		// $('body').addClass('bg-img2');
		// $('body').removeClass('light-theme');
		// $('body').removeClass('dark-menu');
	/* Transparent Bg-Image2 Style End */

	/* Transparent Bg-Image3 Style Start */
		// $('body').addClass('transparent-theme');
		// $('body').addClass('bg-img3');
		// $('body').removeClass('light-theme');
		// $('body').removeClass('dark-menu');
	/* Transparent Bg-Image3 Style End */

	/* Transparent Bg-Image4 Style Start */
		// $('body').addClass('transparent-theme');
		// $('body').addClass('bg-img4');
		// $('body').removeClass('light-theme');
		// $('body').removeClass('dark-menu');
	/* Transparent Bg-Image4 Style End */

	/* Light Menu Start */
		// $('body').addClass('light-menu');
	/* Light Menu End */

	/* Color Menu Start */
		// $('body').addClass('color-menu');
	/* Color Menu End */

	/* Dark Menu Start */
		// $('body').addClass('dark-menu');
	/* Dark Menu End */

	/* Light Header Start */
		// $('body').addClass('header-light');
	/* Light Header End */

	/* Color Header Start */
		// $('body').addClass('color-header');
	/* Color Header End */

	/* Dark Header Start */
		// $('body').addClass('header-dark');
	/* Dark Header End */

	/* Full Width Layout Start */
		// $('body').addClass('layout-fullwidth');
	/* Full Width Layout End */

	/* Boxed Layout Start */
		// $('body').addClass('layout-boxed');
	/* Boxed Layout End */

	/* Header-Fixed Start */
		// $('body').addClass('fixed-layout');
	/* Header-Fixed End */

	/* Header-Scrollable Start */
		// $('body').addClass('scrollable-layout');
	/* Header-Scrollable End */

	/* Default Sidemenu Start */
		// $('body').addClass('default-menu');
	/* Default Sidemenu End */

	/* Icon Text Sidemenu Start */
		// $('body').addClass('icontext-menu');
		// $('body').addClass('main-sidebar-hide');
		// if(document.querySelector('.page').classList.contains('main-signin-wrapper') !== true){
		// 		icontext();
		// }
	/* Icon Text Sidemenu End */

	/* Icon Overlay Sidemenu Start */
		// $('body').addClass('icon-overlay');
		// $('body').addClass('main-sidebar-hide');
	/* Icon Overlay Sidemenu End */

	/* Closed Sidemenu Start */
		// $('body').addClass('closed-leftmenu');
		// $('body').addClass('main-sidebar-hide');
	/* Closed Sidemenu End */

	/* Hover Submenu Start */
		// $('body').addClass('hover-submenu');
		// $('body').addClass('main-sidebar-hide');
		// if(document.querySelector('.page').classList.contains('main-signin-wrapper') !== true){
		// 	hovermenu();
		// }
	/* Hover Submenu End */

	/* Hover Submenu Style 1 Start */
		// $('body').addClass('hover-submenu1');
		// $('body').addClass('main-sidebar-hide');
		// if(document.querySelector('.page').classList.contains('main-signin-wrapper') !== true){
		// 	hovermenu();
		// }
	/* Hover Submenu Style 1 End */

	/* Horizontal Menu Start */
		// $('body').addClass('horizontalmenu');
		// if(document.querySelector('.page').classList.contains('main-signin-wrapper') !== true){
		// 	checkHoriMenu();
		// }
	/*Horizontal Menu End */

	/* Horizontal Hover Menu Start */
		// $('body').addClass('horizontalmenu-hover');
		// if(document.querySelector('.page').classList.contains('main-signin-wrapper') !== true){
		// 	checkHoriMenu();
		// }
	/* Horizontal Hover Menu End */

	/* RTL version Start */
		// $('body').addClass('rtl');
	/* RTL version End */

	//On ready function for Horizontal Menu
	$(document).ready(function () {
		let bodyhorizontal = $('body').hasClass('horizontalmenu');
		if (bodyhorizontal) {
		if (window.innerWidth >= 992) {
			if (document.querySelector('body').classList.contains('horizontalmenu')) {
				var animationSpeed = 300;
				// first level
				var parent = $(".main-menu .with-sub").parents('ul');
				var ul = parent.find('ul:visible').slideUp(animationSpeed);
				ul.removeClass('open');
				var parent1 = $(".main-menu .sub-with-sub").parents('ul');
				var ul1 = parent1.find('ul:visible').slideUp(animationSpeed);
				ul1.removeClass('open');
			}
		}
			$('body').addClass('horizontalmenu');
			$('body').removeClass('leftmenu');
			$('body').removeClass('main-body');
			$('.main-content').addClass('hor-content');
			$('.main-header').addClass(' hor-header');
			$('.main-header').removeClass('sticky');
			$('.main-content').removeClass('side-content');
			$('.main-container').addClass('container');
			$('.main-container-1').addClass('container');
			$('.main-container').removeClass('container-fluid');
			$('.main-menu').addClass('main-navbar hor-menu');
			$('.main-menu').removeClass('main-sidebar main-sidebar-sticky side-menu');
			$('.main-container-1').removeClass('main-sidebar-header');
			$('.main-body-1').removeClass('main-sidebar-body');
			$('.menu-icon').removeClass('sidemenu-icon');
			$('.menu-icon').addClass('hor-icon');
			$('body').removeClass('default-menu');
			$('body').removeClass('closed-leftmenu');
			$('body').removeClass('icontext-menu');
			$('body').removeClass('main-sidebar-hide');
			$('body').removeClass('main-sidebar-open');
			$('body').removeClass('icon-overlay');
			$('body').removeClass('hover-submenu');
			$('body').removeClass('hover-submenu1');
		}
		else {

		}
	});

	//On ready function for Horizontal Hover Menu
	$(document).ready(function () {
		let bodyhorizontal = $('body').hasClass('horizontalmenu-hover');
		if (bodyhorizontal) {
			if (window.innerWidth>=992) {
				let subNavSub = document.querySelectorAll('.sub-nav-sub');
				subNavSub.forEach((e) => {
					e.style.display = '';
				})
				let subNav = document.querySelectorAll('.nav-sub')
				subNav.forEach((e) => {
					e.style.display = '';
				})
			}
			checkHoriMenu();
			$('body').addClass('horizontalmenu');
			$('body').addClass('horizontalmenu-hover');
			$('body').removeClass('leftmenu');
			$('body').removeClass('main-body');
			$('.main-content').addClass('hor-content');
			$('.main-header').addClass(' hor-header');
			$('.main-header').removeClass('sticky');
			$('.main-content').removeClass('side-content');
			$('.main-container').addClass('container');
			$('.main-container-1').addClass('container');
			$('.main-container').removeClass('container-fluid');
			$('.main-menu').addClass('main-navbar hor-menu');
			$('.main-menu').removeClass('main-sidebar main-sidebar-sticky side-menu');
			$('.main-container-1').removeClass('main-sidebar-header');
			$('.main-body-1').removeClass('main-sidebar-body');
			$('.menu-icon').removeClass('sidemenu-icon');
			$('.menu-icon').addClass('hor-icon');
			$('body').removeClass('default-menu');
			$('body').removeClass('closed-leftmenu');
			$('body').removeClass('icontext-menu');
			$('body').removeClass('main-sidebar-hide');
			$('body').removeClass('main-sidebar-open');
			$('body').removeClass('icon-overlay');
			$('body').removeClass('hover-submenu');
			$('body').removeClass('hover-submenu1');
		}
		else {

		}
	});

	$(document).ready(function () {
		let bodyRtl = $('body').hasClass('rtl');
		if (bodyRtl) {
			$('body').addClass('rtl');
			$("html[lang=en]").attr("dir", "rtl");
			localStorage.setItem("rtl", "True");
			$("head link#style").attr("href", $(this));
			(document.getElementById("style")?.setAttribute("href", "../assets/plugins/bootstrap/css/bootstrap.rtl.min.css"));

			var carousel = $('.owl-carousel');
			$.each(carousel, function (index, element) {
				// element == this
				var carouselData = $(element).data('owl.carousel');
				carouselData.settings.rtl = true; //don't know if both are necessary
				carouselData.options.rtl = true;
				$(element).trigger('refresh.owl.carousel');
			});
		}
		else {
			$('body').removeClass('rtl');
			localStorage.setItem("rtl", "false");
			$("head link#style").attr("href", $(this));
			(document.getElementById("style").setAttribute("href", "../assets/plugins/bootstrap/css/bootstrap.min.css"));
		};

	});

});

function resetData() {
	$('#myonoffswitch3').prop('checked', true);
	$('#myonoffswitch6').prop('checked', true);
	$('#myonoffswitch1').prop('checked', true);
	$('#myonoffswitch9').prop('checked', true);
	$('#myonoffswitch10').prop('checked', false);
	$('#myonoffswitch11').prop('checked', true);
	$('#myonoffswitch12').prop('checked', false);
	$('#myonoffswitch13').prop('checked', true);
	$('#myonoffswitch14').prop('checked', false);
	$('#myonoffswitch15').prop('checked', false);
	$('#myonoffswitch16').prop('checked', false);
	$('#myonoffswitch17').prop('checked', false);
	$('#myonoffswitch18').prop('checked', false);
	$('body')?.removeClass('bg-img4');
	$('body')?.removeClass('bg-img1');
	$('body')?.removeClass('bg-img2');
	$('body')?.removeClass('bg-img3');
	$('body')?.removeClass('transparent-theme');
	$('body')?.removeClass('dark-theme');
	$('body')?.addClass('dark-menu');
	$('body')?.removeClass('light-menu');
	$('body')?.removeClass('color-menu');
	$('body')?.removeClass('header-dark');
	$('body')?.removeClass('header-light');
	$('body')?.removeClass('color-header');
	$('body')?.removeClass('layout-boxed');
	$('body')?.removeClass('icontext-menu');
	$('body')?.removeClass('icon-overlay');
	$('body')?.removeClass('closed-leftmenu');
	$('body')?.removeClass('hover-submenu');
	$('body')?.removeClass('hover-submenu1');
	$('body')?.removeClass('scrollable-layout');
	$('body')?.removeClass('fixed-layout');
	$('body')?.removeClass('main-sidebar-hide');

}
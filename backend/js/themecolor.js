
let html =  document.querySelector('html'),
body = document.querySelector('body');

const handleThemeUpdate = (cssVars) => {
const root = document.querySelector(':root');
const keys = Object.keys(cssVars);
keys.forEach(key => {
    root.style.setProperty(key, cssVars[key]);
});
}

function dynamicPrimaryColor(primaryColor) {
primaryColor.forEach((item) => {
    item.addEventListener('input', (e) => {
        const cssPropName = `--primary-${e.target.getAttribute('data-id')}`;
        const cssPropName1 = `--primary-${e.target.getAttribute('data-id1')}`;
        const cssPropName2 = `--primary-${e.target.getAttribute('data-id2')}`;
        const cssPropName7 = `--primary-${e.target.getAttribute('data-id7')}`;
        const cssPropName8 = `--darkprimary-${e.target.getAttribute('data-id8')}`;
        const cssPropName3 = `--dark-${e.target.getAttribute('data-id3')}`;
        const cssPropName4 = `--transparent-${e.target.getAttribute('data-id4')}`;
        const cssPropName5 = `--transparent-${e.target.getAttribute('data-id5')}`;
        const cssPropName6 = `--transparent-${e.target.getAttribute('data-id6')}`;
        const cssPropName9 = `--transparentprimary-${e.target.getAttribute('data-id9')}`;
        handleThemeUpdate({
            [cssPropName]: e.target.value,
            // 95 is used as the opacity 0.95  
            [cssPropName1]: e.target.value + 95,
            [cssPropName2]: e.target.value,
            [cssPropName3]: e.target.value,
            [cssPropName4]: e.target.value,
            [cssPropName5]: e.target.value,
            [cssPropName6]: e.target.value + 95,
            [cssPropName7]: e.target.value + 20,
            [cssPropName8]: e.target.value + 20,
            [cssPropName9]: e.target.value + 20,
        });
    });
});
}

(function() {

'use strict'
// Light theme color picker
const LightThemeSwitchers = document.querySelectorAll('.light-theme .switch_section span');
const dynamicPrimaryLight = document.querySelectorAll('input.color-primary-light');

// themeSwitch(LightThemeSwitchers);
dynamicPrimaryColor(dynamicPrimaryLight);

// dark theme color picker

const DarkThemeSwitchers = document.querySelectorAll('.dark-theme .switch_section span')
const DarkDynamicPrimaryLight = document.querySelectorAll('input.color-primary-dark');

// themeSwitch(DarkThemeSwitchers);
dynamicPrimaryColor(DarkDynamicPrimaryLight);

// tranparent theme color picker

const transparentThemeSwitchers = document.querySelectorAll('.transparent-theme .switch_section span')
const transparentDynamicPrimaryLight = document.querySelectorAll('input.color-primary-transparent');

// themeSwitch(transparentThemeSwitchers);
dynamicPrimaryColor(transparentDynamicPrimaryLight);

// tranparent theme bgcolor picker

const transparentBgThemeSwitchers = document.querySelectorAll('.transparent-theme .switch_section span')
const transparentDynamicPBgLight = document.querySelectorAll('input.color-bg-transparent');

// themeSwitch(transparentBgThemeSwitchers);
dynamicPrimaryColor(transparentDynamicPBgLight);

localStorageBackup();

$('#myonoffswitch1').on('click', function(){
    body?.classList.remove('dark-theme');
    body?.classList.remove('transparent-theme');
    body?.classList.remove('bg-img1');
    body?.classList.remove('bg-img2');
    body?.classList.remove('bg-img3');
    body?.classList.remove('bg-img4');
    
    localStorage.removeItem('BgImage');
    $('#myonoffswitch1').prop('checked', true);

    localStorage.setItem('lightMode', true);
    localStorage.removeItem('darkMode');
    localStorage.removeItem('transparentMode');
})
$('#myonoffswitch2').on('click', function(){
    body?.classList.remove('light-theme');
    body?.classList.remove('transparent-theme');
    body?.classList.remove('bg-img1');
    body?.classList.remove('bg-img2');
    body?.classList.remove('bg-img3');
    body?.classList.remove('bg-img4');

    localStorage.setItem('darkMode', true);
    localStorage.removeItem('lightMode');
    localStorage.removeItem('transparentMode');
    
    localStorage.removeItem('BgImage');
    $('#myonoffswitch2').prop('checked', true);
})
$('#myonoffswitchTransparent').on('click', function(){
    body?.classList.remove('dark-theme');
    body?.classList.remove('light-theme');
    body?.classList.remove('bg-img1');
    body?.classList.remove('bg-img2');
    body?.classList.remove('bg-img3');
    body?.classList.remove('bg-img4');
    
    localStorage.removeItem('BgImage');
    $('#myonoffswitchTransparent').prop('checked', true);
    localStorage.setItem('transparentMode', true);
    localStorage.removeItem('lightMode');
    localStorage.removeItem('darkMode');
})
    
})();

function localStorageBackup() {

'use strict'
// if there is a value stored, update color picker and background color
// Used to retrive the data from local storage
if (localStorage.primaryColor) {
    // document.getElementById('colorID').value = localStorage.primaryColor;
    html.style.setProperty('--primary-bg-color', localStorage.primaryColor);
    html.style.setProperty('--primary-bg-hover', localStorage.primaryHoverColor);
    html.style.setProperty('--primary-bg-border', localStorage.primaryBorderColor);
    html.style.setProperty('--primary-transparentcolor', localStorage.primaryTransparent);
    // body.setAttribute('class', 'app sidebar-mini light-theme');
    
    body.classList.add('light-theme');
    body.classList.remove('dark-theme');
    body.classList.remove('transparent-theme');

    $('#myonoffswitch3').prop('checked', true);
    $('#myonoffswitch6').prop('checked', true);
    $('#myonoffswitch1').prop('checked', true);
}

if (localStorage.darkPrimary) {
    // document.getElementById('darkPrimaryColorID').value = localStorage.darkPrimary;
    html.style.setProperty('--primary-bg-color', localStorage.darkPrimary);
    html.style.setProperty('--primary-bg-hover', localStorage.darkPrimary);
    html.style.setProperty('--primary-bg-border', localStorage.darkPrimary);
    html.style.setProperty('--dark-primary', localStorage.darkPrimary);
    html.style.setProperty('--darkprimary-transparentcolor', localStorage.darkprimaryTransparent);
    // body.setAttribute('class', 'app sidebar-mini dark-theme');
    
    body.classList.remove('light-theme');
    body.classList.add('dark-theme');
    body.classList.remove('transparent-theme');

    $('#myonoffswitch2').prop('checked', true);

}


if (localStorage.transparentPrimary) {
    // document.getElementById('transparentPrimaryColorID').value = localStorage.transparentPrimary;
    html.style.setProperty('--primary-bg-color', localStorage.transparentPrimary);
    html.style.setProperty('--primary-bg-hover', localStorage.transparentPrimary);
    html.style.setProperty('--primary-bg-border', localStorage.transparentPrimary);
    html.style.setProperty('--transparent-primary', localStorage.transparentPrimary);
    html.style.setProperty('--transparentprimary-transparentcolor', localStorage.transparentprimaryTransparent);
    // body.setAttribute('class', 'app sidebar-mini transparent-theme');
    
    body.classList.remove('light-theme');
    body.classList.remove('dark-theme');
    body.classList.add('transparent-theme');

    $('#myonoffswitchTransparent').prop('checked', true);
}

if (localStorage.transparentBgImgPrimary) {
    // document.getElementById('transparentBgImgPrimaryColorID').value = localStorage.transparentBgImgPrimary;
    html.style.setProperty('--primary-bg-color', localStorage.transparentBgImgPrimary);
    html.style.setProperty('--primary-bg-hover', localStorage.transparentBgImgPrimary);
    html.style.setProperty('--primary-bg-border', localStorage.transparentBgImgPrimary);
    html.style.setProperty('--transparent-primary', localStorage.transparentBgImgPrimary);
    html.style.setProperty('--transparentprimary-transparentcolor', localStorage.transparentBgImgprimaryTransparent);
    body?.classList.add('transparent-theme');
    body?.classList.remove('dark-theme');
    body?.classList.remove('light-theme');
    
    $('#myonoffswitchTransparent').prop('checked', true);
}

if (localStorage.transparentBgColor) {
    // document.getElementById('transparentBgColorID').value = localStorage.transparentBgColor;
    html.style.setProperty('--transparent-body', localStorage.transparentBgColor);
    html.style.setProperty('--transparent-theme', localStorage.transparentThemeColor);
    html.style.setProperty('--transparentprimary-transparentcolor', localStorage.transparentprimaryTransparent);
    body.classList.add('transparent-theme');
    body.classList.remove('dark-theme');
    body.classList.remove('light-theme');


    $('#myonoffswitchTransparent').prop('checked', true);
}
if (localStorage.BgImage) {
    body?.classList.add('transparent-theme');
    let bgImg = localStorage.BgImage.split(' ')[0];
    body?.classList.add(bgImg);
    body?.classList.remove('dark-theme');
    body?.classList.remove('light-theme');
    
    $('#myonoffswitchTransparent').prop('checked', true);
}

if(localStorage.lightMode){
    body?.classList.add('light-theme');
    body?.classList.remove('dark-theme');
    body?.classList.remove('transparent-theme');
    $('#myonoffswitch1').prop('checked', true);
    $('#myonoffswitch3').prop('checked', true);
    $('#myonoffswitch6').prop('checked', true);
}
if(localStorage.darkMode){
    body?.classList.remove('light-theme');
    body?.classList.add('dark-theme');
    body?.classList.remove('transparent-theme');
    $('#myonoffswitch2').prop('checked', true);
    $('#myonoffswitch5').prop('checked', true);
    $('#myonoffswitch8').prop('checked', true);
}
if(localStorage.transparentMode){
    body?.classList.remove('light-theme');
    body?.classList.remove('dark-theme');
    body?.classList.add('transparent-theme');
    $('#myonoffswitchTransparent').prop('checked', true);
    $('#myonoffswitch3').prop('checked', false);
    $('#myonoffswitch6').prop('checked', false);
    $('#myonoffswitch5').prop('checked', false);
    $('#myonoffswitch8').prop('checked', false);
}
if(localStorage.horizontal){
    body.classList.add('horizontal')
}
if(localStorage.horizontalHover){
    body.classList.add('horizontal-hover')
}
if(localStorage.rtl){
    body.classList.add('rtl')
}
}

// triggers on changing the color picker
function changePrimaryColor() {

'use strict'
$('#myonoffswitch3').prop('checked', true);
$('#myonoffswitch6').prop('checked', true);
checkOptions();

var userColor = document.getElementById('colorID').value;
localStorage.setItem('primaryColor', userColor);
// to store value as opacity 0.95 we use 95
localStorage.setItem('primaryHoverColor', userColor + 95);
localStorage.setItem('primaryBorderColor', userColor);
localStorage.setItem('primaryTransparent', userColor + 20);

// removing dark theme properties
localStorage.removeItem('darkPrimary')
localStorage.removeItem('transparentBgColor');
localStorage.removeItem('transparentThemeColor');
localStorage.removeItem('transparentPrimary');
localStorage.removeItem('transparentBgImgPrimary');
localStorage.removeItem('transparentBgImgprimaryTransparent');
localStorage.removeItem('darkprimaryTransparent');
body.classList.add('light-theme');
body.classList.remove('transparent-theme');
body.classList.remove('dark-theme');
localStorage.removeItem('BgImage');

$('#myonoffswitch1').prop('checked', true);
names()

localStorage.setItem('lightMode', true);
localStorage.removeItem('darkMode');
localStorage.removeItem('transparentMode');
}

function darkPrimaryColor() {
'use strict'

var userColor = document.getElementById('darkPrimaryColorID').value;
localStorage.setItem('darkPrimary', userColor);
localStorage.setItem('darkprimaryTransparent', userColor + 20);
$('#myonoffswitch5').prop('checked', true);
$('#myonoffswitch8').prop('checked', true);
checkOptions();

// removing light theme data 
localStorage.removeItem('primaryColor')
localStorage.removeItem('primaryHoverColor')
localStorage.removeItem('primaryBorderColor')
localStorage.removeItem('primaryTransparent');
localStorage.removeItem('transparentBgImgPrimary');
localStorage.removeItem('transparentBgImgprimaryTransparent');

localStorage.removeItem('transparentBgColor');
localStorage.removeItem('transparentThemeColor');
localStorage.removeItem('transparentPrimary');
localStorage.removeItem('BgImage');

body.classList.add('dark-theme');
body.classList.remove('light-theme');
body.classList.remove('transparent-theme');

$('#myonoffswitch2').prop('checked', true);
names()

localStorage.setItem('darkMode', true);
localStorage.removeItem('lightMode');
localStorage.removeItem('transparentMode');
}

function transparentPrimaryColor() {
'use strict'

$('#myonoffswitch3').prop('checked', false);
$('#myonoffswitch6').prop('checked', false);
$('#myonoffswitch5').prop('checked', false);
$('#myonoffswitch8').prop('checked', false);

var userColor = document.getElementById('transparentPrimaryColorID').value;
localStorage.setItem('transparentPrimary', userColor);
localStorage.setItem('transparentprimaryTransparent', userColor + 20);

// removing light theme data 
localStorage.removeItem('darkPrimary');
localStorage.removeItem('primaryColor')
localStorage.removeItem('primaryHoverColor')
localStorage.removeItem('primaryBorderColor')
localStorage.removeItem('primaryTransparent');
localStorage.removeItem('transparentBgImgPrimary');
localStorage.removeItem('transparentBgImgprimaryTransparent');
body.classList.add('transparent-theme');
body.classList.remove('light-theme');
body.classList.remove('dark-theme');
body?.classList.remove('bg-img1');
body?.classList.remove('bg-img2');
body?.classList.remove('bg-img3');
body?.classList.remove('bg-img4');

$('#myonoffswitchTransparent').prop('checked', true);
checkOptions();
names()

localStorage.setItem('transparentMode', true);
localStorage.removeItem('lightMode');
localStorage.removeItem('darkMode');
}

function transparentBgImgPrimaryColor() {
'use strict'
$('#myonoffswitch3').prop('checked', false);
$('#myonoffswitch6').prop('checked', false);
$('#myonoffswitch5').prop('checked', false);
$('#myonoffswitch8').prop('checked', false);
var userColor = document.getElementById('transparentBgImgPrimaryColorID').value;
localStorage.setItem('transparentBgImgPrimary', userColor);
localStorage.setItem('transparentBgImgprimaryTransparent', userColor+20);
if(
    body?.classList.contains('bg-img1') == false &&
    body?.classList.contains('bg-img2') == false &&
    body?.classList.contains('bg-img3') == false &&
    body?.classList.contains('bg-img4') == false
    ){
    body?.classList.add('bg-img1');
    localStorage.setItem('BgImage', 'bg-img1')
}
// removing light theme data 
localStorage.removeItem('darkPrimary');
localStorage.removeItem('primaryColor')
localStorage.removeItem('primaryHoverColor')
localStorage.removeItem('primaryBorderColor')
localStorage.removeItem('primaryTransparent');
localStorage.removeItem('darkprimaryTransparent');
localStorage.removeItem('transparentPrimary')
localStorage.removeItem('transparentprimaryTransparent');
body.classList.add('transparent-theme');
body?.classList.remove('light-theme');
body?.classList.remove('dark-theme');

$('#myonoffswitchTransparent').prop('checked', true);
checkOptions();
names();

localStorage.setItem('transparentMode', true);
localStorage.removeItem('lightMode');
localStorage.removeItem('darkMode');
}


function transparentBgColor() {
'use strict'
$('#myonoffswitch3').prop('checked', false);
$('#myonoffswitch6').prop('checked', false);
$('#myonoffswitch5').prop('checked', false);
$('#myonoffswitch8').prop('checked', false);
var userColor = document.getElementById('transparentBgColorID').value;
localStorage.setItem('transparentBgColor', userColor);
localStorage.setItem('transparentThemeColor', userColor + 95);
localStorage.setItem('transparentprimaryTransparent', userColor + 20);
localStorage.removeItem('transparentBgImgPrimary');
localStorage.removeItem('transparentBgImgprimaryTransparent');

// removing light theme data 
localStorage.removeItem('darkPrimary');
localStorage.removeItem('primaryColor')
localStorage.removeItem('primaryHoverColor')
localStorage.removeItem('primaryBorderColor')
localStorage.removeItem('primaryTransparent');
localStorage.removeItem('BgImage');
body.classList.add('transparent-theme');
body.classList.remove('light-theme');
body.classList.remove('dark-theme');
body?.classList.remove('bg-img1');
body?.classList.remove('bg-img2');
body?.classList.remove('bg-img3');
body?.classList.remove('bg-img4');

$('#myonoffswitchTransparent').prop('checked', true);
checkOptions();

localStorage.setItem('transparentMode', true);
localStorage.removeItem('lightMode');
localStorage.removeItem('darkMode');
}


function bgImage(e) {
'use strict'

$('#myonoffswitch3').prop('checked', false);
$('#myonoffswitch6').prop('checked', false);
$('#myonoffswitch5').prop('checked', false);
$('#myonoffswitch8').prop('checked', false);
let imgID = e.getAttribute('class');
localStorage.setItem('BgImage', imgID);

// removing light theme data 
localStorage.removeItem('darkPrimary');
localStorage.removeItem('primaryColor')
localStorage.removeItem('transparentBgColor');
localStorage.removeItem('transparentThemeColor');
localStorage.removeItem('transparentprimaryTransparent');
body.classList.add('transparent-theme');
body?.classList.remove('light-theme');
body?.classList.remove('dark-theme');

$('#myonoffswitchTransparent').prop('checked', true);
checkOptions();

localStorage.setItem('transparentMode', true);
localStorage.removeItem('lightMode');
localStorage.removeItem('darkMode');
}

// to check the value is hexa or not
const isValidHex = (hexValue) => /^#([A-Fa-f0-9]{3,4}){1,2}$/.test(hexValue)

const getChunksFromString = (st, chunkSize) => st.match(new RegExp(`.{${chunkSize}}`, "g"))
// convert hex value to 256
const convertHexUnitTo256 = (hexStr) => parseInt(hexStr.repeat(2 / hexStr.length), 16)
// get alpha value is equla to 1 if there was no value is asigned to alpha in function
const getAlphafloat = (a, alpha) => {
    if (typeof a !== "undefined") { return a / 255 }
    if ((typeof alpha != "number") || alpha < 0 || alpha > 1) {
        return 1
    }
    return alpha
}
// convertion of hex code to rgba code 
function hexToRgba(hexValue, alpha) {
'use strict'
if (!isValidHex(hexValue)) { return null }
const chunkSize = Math.floor((hexValue.length - 1) / 3)
const hexArr = getChunksFromString(hexValue.slice(1), chunkSize)
const [r, g, b, a] = hexArr.map(convertHexUnitTo256)
return `rgba(${r}, ${g}, ${b}, ${getAlphafloat(a, alpha)})`
}


let myVarVal, myVarVal1, myVarVal2, myVarVal3

function names() {

'use strict'
let primaryColorVal = getComputedStyle(document.documentElement).getPropertyValue('--primary-bg-color').trim();

//get variable
myVarVal = localStorage.getItem("primaryColor") || localStorage.getItem("darkPrimary") || localStorage.getItem("transparentPrimary") || localStorage.getItem("transparentBgImgPrimary")  || primaryColorVal;

if(document.querySelector('#statistics1') !== null){
    statistics1();
}

if(document.querySelector('#Viewers') !== null){
    viewers();
}

if(document.querySelector('.chart-circle') !== null){
    chartCircle();
}    

if(document.querySelector('#statistics2') !== null){
    statistics2();
}

if(document.querySelector('#budget') !== null){
    budget();
}

if(document.querySelector('#Viewers1') !== null){
    viewers1();
}   

if(document.querySelector('#statistics3') !== null){
    statistics3();
}

if(document.querySelector('#Viewers2') !== null){
    viewers2();
}

let colorData = hexToRgba(myVarVal || primaryColorVal, 0.1)
html.style.setProperty('--primary01', colorData);

let colorData1 = hexToRgba(myVarVal || primaryColorVal, 0.2)
html.style.setProperty('--primary02', colorData1);

let colorData2 = hexToRgba(myVarVal || primaryColorVal, 0.3)
html.style.setProperty('--primary03', colorData2);

let colorData3 = hexToRgba(myVarVal || primaryColorVal, 0.6)
html.style.setProperty('--primary06', colorData3);

let colorData4 = hexToRgba(myVarVal || primaryColorVal, 0.9)
html.style.setProperty('--primary09', colorData4);

}
names()


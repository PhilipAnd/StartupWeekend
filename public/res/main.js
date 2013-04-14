var isFrontPageLoaded = false;
var isAdsPageLoaded = false;

$(document).ready(function(){
  loadFrontPage();

  setTimeout(function(){placeFooter()}, 3000);
  
  $(window).resize(function(){
    placeFooter();
  });

  $(window).scroll(function() {
    $('#modalAlreadyFiltered').fadeOut(500);
  });

  $('#aFrontPage').click(function(){
    loadFrontPage();
  });

  $('#aAdsPage').click(function(){
    loadAdsPage();
  });        
});

function placeFooter()
{
  var footer = $('#modalAlreadyFiltered');
  var wHeight = $(window).height();
  var footerHeight = footer.height();
  var offset = parseInt(wHeight) - parseInt(footerHeight);
  footer.css('top',offset);
  footer.fadeIn('3000');
};

function loadFrontPage(){
  $('#divAdsPage').hide();
  $('#divFrontPage').show();
  if(!isFrontPageLoaded)
  {
    $('#ulAdvertisers').approveadvertisers({
      templateSelector: '#advertiserItemTmpl',
      approveSelector: '.js_approveAdvertiser',
      disapproveSelector: '.js_disapproveAdvertiser'
    });
    isFrontPageLoaded = true;
  }
};

function loadAdsPage()
{
  $('#divAdsPage').show();
  $('#divFrontPage').hide();
  if(!isAdsPageLoaded)
  {
    $('#divAds').ads({
        templateSelector: '#adsItemTmpl',
        approveSelector: '.adHover .add',
        disapproveSelector: '.adHover .remove'
      });
    isAdsPageLoaded = true;
  }
};

function closeOverlay(){
  $('#modalAlreadyFiltered').fadeOut();
};
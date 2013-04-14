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
  $('#modalAlreadyFiltered').addClass('visible');
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
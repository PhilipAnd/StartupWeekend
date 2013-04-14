var isFrontPageLoaded = false;
var isAdsPageLoaded = false;

$(document).ready(function(){
  loadFrontPage();

  setTimeout(function(){
    $('.js_moreAdvertisers').fadeIn(3000);
  }, 7000);

  $('#modalAlreadyFiltered').addClass('visible');
    var hideFiltered = function() { $('#modalAlreadyFiltered').removeClass('visible'); return false; };
  $('#modalAlreadyFiltered .close-overlay').click(hideFiltered);
  $(window).scroll(hideFiltered);

  $('#aFrontPage').click(function(){
    loadFrontPage();
  });

  $('#aAdsPage').click(function(){
    loadAdsPage();
  });
});


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
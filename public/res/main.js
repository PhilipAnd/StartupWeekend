var isFrontPageLoaded = false;
var isAdsPageLoaded = false;

$(document).ready(function(){
  loadFrontPage();
<<<<<<< HEAD

  setTimeout(function(){placeFooter()}, 3000);

  setTimeout(function(){
    $('.js_moreAdvertisers').fadeIn(3000);
  }, 5000);

  $(window).resize(function(){
    placeFooter();
  });

  $(window).scroll(function() {
    $('#modalAlreadyFiltered').fadeOut(500);
  });
=======
  $('#modalAlreadyFiltered').addClass('visible');
  $('#modalAlreadyFiltered .close-overlay').click(function() { $('#modalAlreadyFiltered').removeClass('visible'); return false; });
>>>>>>> efabfcdb1d90ea9dcaec5fcdf3c716d7a874f383

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
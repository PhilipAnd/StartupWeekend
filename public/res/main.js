$(document).ready(function(){
  loadFrontPage();

  setTimeout(function(){placeFooter()}, 3000);
  
  $(window).resize(function(){
    placeFooter();
  });

  $('#aFrontPage').click(function(){
    loadFrontPage();
  });

  $('#aAdsPage').click(function(){
    loadAdsPage();
  });        
});

function loadFrontPage(){
  if($('#divAdsPage').is(':visible'))
  {
    $('#divAds').ads('destroy');
  }
  $('#divAdsPage').hide();
  $('#divFrontPage').show();
  $('#ulAdvertisers').approveadvertisers({
    templateSelector: '#advertiserItemTmpl',
    approveSelector: '.js_approveAdvertiser',
    disapproveSelector: '.js_disapproveAdvertiser'
  });
};

function placeFooter()
{
  var footer = $('#modalAlreadyFiltered');
  var wHeight = $(window).height();
  var footerHeight = footer.height();
  var offset = parseInt(wHeight) - parseInt(footerHeight);
  footer.css('top',offset);
  footer.fadeIn('3000');
};

function loadAdsPage()
{
  $('#ulAdvertisers').approveadvertisers('destroy');
  $('#divAdsPage').show();
  $('#divFrontPage').hide();
  $('#divAds').ads({
      templateSelector: '#adItemTmpl',
      approveSelector: '.adHover .add',
      disapproveSelector: '.adHover .remove'
    });
};

function closeOverlay(){
  $('#modalAlreadyFiltered').fadeOut();
};
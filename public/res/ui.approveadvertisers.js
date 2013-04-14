//$.ui.approveadvertisers = {
$.widget( "ui.approveadvertisers", {
  options:
  { 
    templateSelector: '',
    approveSelector: '',
    disapproveSelector: ''
  },
  _create: function () {
    var self = this;
    this._getIntialData(this._renderAdvertisers);
    this._setupClickEvents();
    this._setupInjectAd();
  },
  _renderAdvertisers: function(self, data){
    $(self.options.templateSelector).tmpl(data).appendTo(self.element);
  },
  _setupInjectAd: function(){
    var self = this;
    /*setInterval(function(){ 
      self._loadMoreAdvertisers(1,true)
    },15000);*/
  },
  _setupClickEvents: function()
  {
    var self = this;

    this.element.on('click', self.options.approveSelector, function(){
      self._approveAdvertiser(this);
    });

    this.element.on('click', self.options.disapproveSelector, function(){
      self._disaproveAdvertiser(this);
    });
  },
  _approveAdvertiser: function(element,id)
  {
    $(element).parents('.js_advertisers').fadeOut();
    this._loadMoreAdvertisers(1);
    this._updateApprovedAdvertisers();
  },
  _disaproveAdvertiser: function(element,id)
  {
    $(element).parents('.js_advertisers').fadeOut();
    this._loadMoreAdvertisers(1);
    $('#modalRejection').modal({keyboard:false});
    this.updateDisapprovedAdvertisers();
  },
  _loadMoreAdvertisers: function(count, appendToTop){
    return;
    /*var data = [
      {
        brandImage: "http://a0.twimg.com/profile_images/1884480827/profilePic_reasonably_small.jpg",
        brandName: "Coca Cola",
        kloutScore: 91,
        description: 'Klout score. @CocaCola'
      }
    ]; 

    var item = $(this.options.templateSelector).tmpl(data);
    if(appendToTop)
    {
      item.fadeIn(1000).prependTo(this.element);
    }else{
      item.fadeIn(1500).appendTo(this.element);
    }
    */
  },
  _updateApprovedAdvertisers: function(){
    var countElement = $('#advertiserApprovedCount');
    var newCount = this._getNumber(countElement.text()) +1;
    countElement.fadeOut(function(){
      countElement.text(newCount).fadeIn(2000);
    });
    countElement.text(newCount);
  },
  updateDisapprovedAdvertisers: function(){
    var countElement = $('#advertiserDisapprovedCount');
    var newCount = this._getNumber(countElement.text()) + 1;
    countElement.fadeOut(function(){
      countElement.text(newCount).fadeIn(2000);
    });
    countElement.text(newCount);
  },
  // Get number from approved/disapproved string
  _getNumber: function(inputString){
    if(inputString == "")
    {
      return 0;
    }
    return parseInt(inputString);
  },
  _getIntialData: function(){
    var self = this;
    $.getJSON('/advertisers',function(data){
      self._renderAdvertisers(self,data);
    });
  },
  destroy: function () {
      // if using jQuery UI 1.8.x
      $.Widget.prototype.destroy.call(this);
      // if using jQuery UI 1.9.x
      //this._destroy();
  }
});
//$.widget("ui.approveadvertisers", $.ui.approveadvertisers);
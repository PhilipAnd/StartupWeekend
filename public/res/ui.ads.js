//$.ui.approveadvertisers = {
$.widget( "ui.ads", {
  options:
  { 
    templateSelector: '',
    approveSelector: '',
    disapproveSelector: ''
  },
  _create: function () {

    /*this.element.masonry({
      itemSelector: '.box',
      columnWidth: 150
    });*/
    this._getIntialData(this._renderAdvertisers);
    this._setupClickEvents();
  },
  _renderAdvertisers: function(self, data){
    $(self.options.templateSelector).tmpl(data).appendTo(self.element);
  },
  _getIntialData: function(){
    var self = this;
    $.getJSON("/ads",function(data){
      self._renderAdvertisers(self,data);
    });
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
    $(element).parents('.box').fadeOut();
    this._updateApprovedAds();
    //this._loadMoreAdvertisers(1);
  },
  _disaproveAdvertiser: function(element,id)
  {
    $(element).parents('.box').fadeOut();
    //this._loadMoreAdvertisers(1);
    $('#modalRejection').modal({keyboard:false});
    this._updateDisapprovedAds();
  },
  _updateApprovedAds: function(){
    var countElement = $('#adsApprovedCount');
    var newCount = this._getNumber(countElement.text()) +1;
    countElement.fadeOut(function(){
      countElement.text(newCount).fadeIn(2000);
    });
    countElement.text(newCount);
  },
  _updateDisapprovedAds: function(){
    var countElement = $('#adsDisapprovedCount');
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
  _loadMoreAdvertisers: function(count){
    var data = [
      {
        brandImage: "http://a0.twimg.com/profile_images/1884480827/profilePic_reasonably_small.jpg",
        brandName: "Coca Cola",
        kloutScore: 91,
        description: 'Klout score. @CocaCola'
      }
    ]; 

    var item = $(this.options.templateSelector).tmpl(data);
    item.fadeIn(1000).appendTo(this.element);
  },
  destroy: function () {
      this.element.off(this.options.approveSelector,'click');
      this.element.off(this.options.disapproveSelector,'click');
      // if using jQuery UI 1.8.x
      $.Widget.prototype.destroy.call(this);
      // if using jQuery UI 1.9.x
      //this._destroy();
  }
});
//$.widget("ui.approveadvertisers", $.ui.approveadvertisers);
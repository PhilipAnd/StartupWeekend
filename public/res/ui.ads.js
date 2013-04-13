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
    //this._getIntialData(this._renderAdvertisers);
    this._setupClickEvents();
  },
  _renderAdvertisers: function(self, data){
    $(self.options.templateSelector).tmpl(data).appendTo(self.element);
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
    //this._loadMoreAdvertisers(1);
  },
  _disaproveAdvertiser: function(element,id)
  {
    $(element).parents('.box').fadeOut();
    //this._loadMoreAdvertisers(1);
    $('#modalRejection').modal({keyboard:false});
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
  _getIntialData: function(){
    var data = [
      {
        title: 'New Relic',
        description: 'Speed Up Your Code! Try New Relic Free and Get This Awesome Shirt!',
        imageName: 'bigcommerce',
      },
      {
        title: '',
        description: '',
        imageName: ''
      },
    ];
    this._renderAdvertisers(this,data);
  },
  destroy: function () {
      // if using jQuery UI 1.8.x
      $.Widget.prototype.destroy.call(this);
      // if using jQuery UI 1.9.x
      //this._destroy();
  }
});
//$.widget("ui.approveadvertisers", $.ui.approveadvertisers);
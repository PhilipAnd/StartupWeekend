//$.ui.approveadvertisers = {
$.widget( "ui.approveadvertisers", {
  options:
  { 
    templateSelector: '',
    approveSelector: '',
    disapproveSelector: ''
  },
  _create: function () {
    this._getIntialData(this._renderAdvertisers);
  },
  _renderAdvertisers: function(self, data){
    $(self.options.templateSelector).tmpl(data).appendTo(self.element);
  },
  _setupClickEvents: function()
  {
    var self = this;
    this.element.on('click', this.options.approveSelector,function(){
      console.log('approved ');
      self._loadMoreAdvertisers(1);
    });

    this.element.on('click', this.options.disapproveSelectors,function(){
      console.log('disapproved');
      self._loadMoreAdvertisers(1);
    });
  },
  _approveAdvertiser: function(id)
  {

  },
  _disaproveAdvertiser: function(id)
  {

  },
  _loadMoreAdvertisers: function(count){
    //TODO
  },
  _getIntialData: function(){
    var data = [
      {
        brandImage: "http://a0.twimg.com/profile_images/1884480827/profilePic_reasonably_small.jpg",
        brandName: "Coca Cola",
        kloutScore: 91,
        kloutDescription: 'Klout score. @CocaCola'
      },
      {
        brandImage: "http://a0.twimg.com/profile_images/1884480827/profilePic_reasonably_small.jpg",
        brandName: "Coca Cola",
        kloutScore: 91,
        kloutDescription: 'Klout score. @CocaCola'
      }
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
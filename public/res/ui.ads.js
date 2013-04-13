$.ui.adverts = {
  _create: function () {
    this._getData(this._renderAdverts);
  },
  _renderAdverts: function(data){
    $.tmpl(this.options.templateSelector, _getData()).appendTo(this.element);
  },
  _getData: function(callBack){
    var data = 
    {
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
    };

    callBack(data);
  },
  destroy: function () {
      // if using jQuery UI 1.8.x
      $.Widget.prototype.destroy.call(this);
      // if using jQuery UI 1.9.x
      //this._destroy();
  },
  options:
  { 
    templateSelector: ''
  }
};
$.widget("ui.adverts", $.ui.adverts);
class Devices < Netzke::Basepack::Viewport

  component :devices do |c|
    c.klass = Netzke::Basepack::Grid
    c.model = "Device"
  end

  js_configure do |c|
    c.layout = :border  # position bbar at bottom
  end

  def configure(c)
    super
    c.items = [
        { border:false, region:'north', html:header_html },
        { border:false, region:'center', layout:'fit', items:[:devices] }
    ]
  end

  def header_html
    %Q{
      <div data-theme="c" data-role="header" class="jqm-header ui-header ui-bar-c" role="banner">
        <h1 class="ui-title" role="heading" aria-level="1">
          <a id="logo" href="/" class="ui-link">ZinLot</a>
        </h1>
        <a href="#historical_trips-index-navmenu" data-iconpos="notext" data-icon="bars" class="jqm-navmenu-link ui-btn-left ui-btn ui-btn-up-c ui-shadow ui-btn-corner-all ui-btn-icon-notext" data-corners="true" data-shadow="true" data-iconshadow="true" data-wrapperels="span" data-theme="c" title=""><span class="ui-btn-inner"><span class="ui-btn-text"></span><span class="ui-icon ui-icon-bars ui-icon-shadow">&nbsp;</span></span></a>
      </div>
    }
  end
end
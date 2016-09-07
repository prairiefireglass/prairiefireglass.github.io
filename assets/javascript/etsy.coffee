---
---

$ ->
  getEtsyItems()


getEtsyItems = ->
  $el = $('[data-behavior~=etsy-items]')

  if $el.length
    $el.addClass "loading"
    limit = $el.data 'limit'

    if $el.data('featured')
      url = "https://openapi.etsy.com/v2/shops/JimDowney/listings/featured.js?limit=#{limit}&includes=Images:1&api_key=s8b6yegjtvhbeoz1nmgs0n9n"
    else
      url = "https://openapi.etsy.com/v2/shops/JimDowney/listings/active.js?limit=#{limit}&includes=Images:1&api_key=s8b6yegjtvhbeoz1nmgs0n9n"

    $.ajax
      url: url
      dataType: "jsonp"
      success: (data) ->
        $el.removeClass "loading"
        if data.ok and data.count > 0
          $.each data.results, (i, item) ->
            $el.append '<figure><span><a href="' + item.url + '"><img src="' + item.Images[0].url_570xN + '"><figcaption>' + item.title + '<div class="price">$' + Math.round(item.price) + '</div></figcaption></a></span></figure>'
            return
        else
          console.log data.error
        return

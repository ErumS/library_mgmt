$("document").ready(function(){
  $("#show_lib").hide();
  $.ajax({
    type: "GET",
    dataType: 'json',
    url: "http://localhost:3000/libraries",
  })
  .done(function(data)
  {
    var table = data.library;
    $.each(table, function (i, item) 
    {
      table = $("#template").clone();
      table.find("#name").html(item.name);
      table.find("#address").html(item.address);
      table.find("#phone_no").html(item.phone_no);
      table.find("#show").html("<button onclick = show(" + item.id +  ") >Show</button>");
      table.find("#delete").html("<button onclick = destroy(" + item.id +  ") >Destroy</button>");
      $(".library").append(table);
    });
  })
  .fail(function(textStatus)
  {
    alert(textStatus) 
  });
});

function destroy(id) 
{
  if(confirm("Are you sure?"))
  {
    $.ajax({
      type: "POST",
      url: "http://localhost:3000/libraries/" + id,
      dataType: 'json',
      data: {"_method":"delete"}
    });
    event.preventDefault();
    window.location.reload();
  }
}

function creation(name,address,phone_no)
{
  var library = { "library": { "name":name, "address":address, "phone_no":phone_no }};
  $.ajax({
    type: "POST",
    url: "/libraries",
    data: library,
    dataType: 'json',
    success: function(result){
      console.log(result);
      window.open("/libraries","_self")
    }
  });
}

function show(id)
{
  $.ajax({
    type: "GET",
    url: "http://localhost:3000/libraries/" + id,
    dataType: 'json',
    success: function(data){
      $("#index_lib").hide();
      $("#show_lib").show();
      var table = data.library;
      var item = $("#show_template");
      item.find("#name").html(table.name);
      item.find("#address").html(table.address);
      item.find("#phone_no").html(table.phone_no);
      item.find("#back").html("<button onclick = back() >Back</button>");
      $("#show_template").append(item);
    },
    error: function (result) {
      alert('error happened');
    }
  })
}

function back()
{
  window.location.reload("/libraries","_self")
}
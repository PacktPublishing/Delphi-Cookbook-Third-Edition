// The root URL for the RESTful services
var rootURL = "/books";

var currentBook;

$(document).ready(function(){

  // Retrieve books list when application starts
  findAll();
  
  // Nothing to delete in initial application state
  $('#btnDelete').hide();

  
  // Register listeners for add a book

  $('#btnAdd').click(function() {
      newBook();
      return false;
  });

  $('#btnSave').click(function() {
      if ($('#bookId').val() == '')
			{
          addBook();

			}
      else
          updateBook();
      return false;
  });

  $('#btnDelete').click(function() {
      deleteBook();
      return false;
  });

  $('#booksList a').live('click', function() {
      findById($(this).data('identity'));
  });

  // Replace broken images with generic book folder
  $("img").error(function(){
    $(this).attr("src", "pics/generic.jpg");

  });

});

function newBook() {
	$('#btnDelete').hide();
	currentBook = {};
	renderDetails(currentBook); // Display empty form
}

function findAll() {
	console.log('findAll');
	$.ajax({
		type: 'GET',
		url: rootURL,
		dataType: "json", // data type of response
		success: renderList
	});
}

function findById(id) {
	console.log('findById: ' + id);
	$.ajax({
		type: 'GET',
		url: rootURL + '/' + id,
		dataType: "json",
		success: function(data){
			$('#btnDelete').show();
			console.log('findById success: ' + data.name);
			currentBook = data;
			renderDetails(currentBook);
		}
	});
}

function addBook() {
	console.log('addBook');
	$.ajax({
		type: 'POST',
		contentType: 'application/json',
		url: rootURL,
		dataType: "json",
		data: formToJSON(),
		success: function(data, textStatus, jqXHR){
			alert('Book created successfully');
			findAll();
			$('#btnDelete').show();
			$('#bookId').val(data.id);
			findById(data.id);
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert('addBook error: ' + textStatus);
		}
	});
}

function updateBook() {
	console.log('updateBook');
	$.ajax({
		type: 'PUT',
		contentType: 'application/json',
		url: rootURL + '/' + $('#bookId').val(),
		dataType: "json",
		data: formToJSON(),
    processData: false,
		success: function(data, textStatus, jqXHR){
            debugger;
			alert('Book updated successfully');
			findAll();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert('updateBook error: ' + textStatus);
		}
	});
}

function deleteBook() {
	console.log('deleteBook');
	$.ajax({
		type: 'DELETE',
		url: rootURL + '/' + $('#bookId').val(),
		success: function(data, textStatus, jqXHR){
			alert('Book deleted successfully');
            findAll();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert('deleteBook error');
		}
	});
}

function renderList(data) {
	// DMVC Server serializes an empty list as null, and a 'collection of one' as an object (not an 'array of one')
	//var list = data == null ? [] : (data.book instanceof Array ? data.book : [data.book]);
    //debugger;
    var list = data;
	$('#booksList div').remove();
	$.each(list, function(index, book) {
		$('#booksList').append(`<div class="col-4">
		<div class="card">
			<img class="card-img-top img-responsive" src="./pics/generic.jpg" alt="Card image cap">
			<div class="card-body">
				<h5 class="card-title">${book.title}</h5>
				<p class="card-text">${book.plot}</p>
				<p> <small class="font-weight-bold"> Author </small> <span class="badge badge-secondary">${book.author}</span></p>
				<p> <small class="font-weight-bold"> Year </small> <span class="badge badge-secondary">${book.year}</span></p>
				<p> <small class="font-weight-bold"> Pages </small> <span class="badge badge-secondary">${book.number_of_pages}</span></p>
				<a href="#" class="btn btn-warning" data-identity="${book.id}">Edit</a>
			</div>
		</div>
	</div>`);		
	});
}

function renderDetails(book) {
	$('#bookId').val(book.id);
	$('#title').val(book.title);
	$('#author').val(book.author);
	$('#year').val(book.year);
	$('#number_of_pages').val(book.number_of_pages);
	$('#pic').attr('src', 'pics/' + book.picture);
	$('#plot').val(book.plot);
}

// Helper function to serialize all the form fields into a JSON string
function formToJSON() {
	return JSON.stringify({
		"id": parseInt($('#bookId').val()),
		"title": $('#title').val(),
		"author": $('#author').val(),
		"year": parseInt($('#year').val()),
		"number_of_pages": parseInt($('#number_of_pages').val()),
		"picture": currentBook.picture,
		"plot": $('#plot').val()
		});
}

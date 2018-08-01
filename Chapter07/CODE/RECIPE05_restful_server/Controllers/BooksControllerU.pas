unit BooksControllerU;

interface

uses MVCFramework, BooksModuleU, MVCFramework.Commons;

type

  [MVCPath('/books')]
  TBooksController = class(TMVCController)
  private
    FBookModule: TBookModule;
  protected
    procedure OnAfterAction(Context: TWebContext;
      const AActionNAme: string); override;
    procedure OnBeforeAction(Context: TWebContext; const AActionNAme: string;
      var Handled: Boolean); override;
  public
    [MVCPath]
    [MVCHTTPMethod([httpGET])]
    procedure GetBooks;
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetBookByID;
    [MVCPath]
    [MVCHTTPMethod([httpPOST])]
    [MVCConsumes('application/json')]
    procedure CreateBook;
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpPUT])]
    [MVCConsumes('application/json')]
    procedure UpdateBook;
    [MVCPath('/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteBook;
  end;

implementation

uses
  BookBO, SysUtils, System.JSON, System.Math;

procedure TBooksController.CreateBook;
var
  Book: TBook;
begin
  Book := Context.Request.BodyAs<TBook>;
  FBookModule.CreateBook(Book);
  Context.Response.Location := '/books/' + Book.ID.ToString;
  Render(201, 'Book created');
end;

procedure TBooksController.UpdateBook;
var
  Book: TBook;
begin
  Book := Context.Request.BodyAs<TBook>;
  try
    Book.ID := Context.Request.ParamsAsInteger['id'];
    FBookModule.UpdateBook(Book);
    Render(200, 'Book updated');
  finally
    Book.Free;
  end;
end;

procedure TBooksController.DeleteBook;
begin
  FBookModule.DeleteBook(Context.Request.ParamsAsInteger['id']);
  Render(204, 'Book deleted');
end;

procedure TBooksController.GetBookByID;
var
  Book: TBook;
begin
  Book := FBookModule.GetBookByID(Context.Request.ParamsAsInteger['id']);
  if Assigned(Book) then
    Render(Book, false)
  else
    Render(404, 'Book not found');
end;

procedure TBooksController.GetBooks;
begin
  Render<TBook>(FBookModule.GetBooks, false);
end;

procedure TBooksController.OnAfterAction(Context: TWebContext;
  const AActionNAme: string);
begin
  inherited;
  FBookModule.Free;
end;

procedure TBooksController.OnBeforeAction(Context: TWebContext;
  const AActionNAme: string; var Handled: Boolean);
begin
  inherited;
  FBookModule := TBookModule.Create(nil);
end;

end.

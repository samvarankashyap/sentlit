<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Imagen Cara</title>
    <meta name="author" content="LayoutIt!">
     <link href="/static/bootstrap.min.css" rel="stylesheet">
    <link href="/static/style.css" rel="stylesheet">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.4/jquery.min.js"></script>
    <script>
    $( document ).ready(function() {
           $("#uploadform").submit(function(event) {
                      event.preventDefault();
                     var data = new FormData(this);
                     console.log(data);
                   $.ajax({
                       type        : "POST",
                       url         : "/uploadimage",
                       data        : data,
                       contentType : false,
                       processData : false
                       }).done(function (data) {
                            console.log(data);
                       });
            });
          });


  </head>
  <body>

    <div class="container-fluid">
	<div class="row">
		<div class="col-md-12">
			<div class="page-header">
				<h1>
					Sentiment analyis of text
				</h1>
			</div>
			<div class="row">
				<div class="col-md-2">
					
				</div>
				<div class="col-md-10">
                                         <h2>Upload Data</h2>
					 <a id="modal-812511" href="#modal-container-812511" role="button" class="btn" data-toggle="modal">Upload Data </a>
					
					<div class="modal fade" id="modal-container-812511" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									 
									<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
										×
									</button>
									<h4 class="modal-title" id="myModalLabel">
										Upload a Picture
									</h4>
								</div>
								<div class="modal-body">
                                                                        <form id="uploadform" >
									Select File : <input type="file" id="uploadimage" name="uploadimage"><br>
                                                                        <input type="hidden" name="username" value="" id="hiddenusername">
                                                                        <input type="submit" id="uploadbtn" value="Upload">
                                                                        </form>
								</div>
								<div class="modal-footer">
									 
									<button type="button" class="btn btn-default" data-dismiss="modal">
										Close
									</button> 
									<button type="button" class="btn btn-primary">
										Save changes
									</button>
								</div>
							</div>
							
						</div>
						
					</div>
                                        <div id="feed">
                                        </div>
				</div>
			</div>
		</div>
	</div>
</div>

    <script src="/static/jquery.min.js"></script>
    <script src="/static/bootstrap.min.js"></script>
    <script src="/static/scripts.js"></script>
  </body>
</html>

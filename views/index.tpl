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
    <script src="/static/jquery.min.js"></script>
    <link href="/static/justified-nav.css" rel="stylesheet">
    <script src="/static/d3.v3.min.js" charset="utf-8"></script>
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
                         //start of function 
                            console.log(data);
                            data = JSON.parse(data)
                            data1 = data[0];
                            data2 = data[1];
                            data3 = data[2];
                            console.log(data[4]);

                          InitChart(data1,data2,data3) ;
                          



// barchar1 start

$("#senti").append("<h2>Sentiment word counts of of Pos , Neg and Objective words</h2> <br>")
var dataset = data[3];

   var w = 1500;
        var h = 500;
        //var dataset = [ { key: 0, value: 5 },{ key: 1, value: 10 },{ key: 2, value: 13 },{ key: 3, value: 19 },{ key: 4, value: 21 },{ key: 5, value: 25 },{ key: 6, value: 22 },{ key: 7, value: 18 },{ key: 8, value: 15 },{ key: 9, value: 13 },{ key: 10, value: 11 },{ key: 11, value: 12 },{ key: 12, value: 15 },{ key: 13, value: 20 },{ key: 14, value: 18 },{ key: 15, value: 17 },{ key: 16, value: 16 },{ key: 17, value: 18 },{ key: 18, value: 23 },{ key: 19, value: 25 } ];
var xScale = d3.scale.ordinal()
				.domain(d3.range(dataset.length))
				.rangeRoundBands([0, w], 0.10); 
var yScale = d3.scale.linear()
				.domain([0, d3.max(dataset, function(d) {return d.value;})])
				.range([0, h]);
var key = function(d) {
	return d.key;
};
//Create SVG element
var svg = d3.select("span")
			.append("svg")
			.attr("width", w)
			.attr("height", h);
//Create bars
svg.selectAll("rect")
   .data(dataset, key)
   .enter()
   .append("rect")
   .attr("x", function(d, i) {
		return xScale(i);
   })
   .attr("y", function(d) {
		return h - yScale(d.value);
   })
   .attr("width", xScale.rangeBand())
   .attr("height", function(d) {
		return yScale(d.value);
   })
   .attr("fill", function(d) {
		return "rgb(0, 0, " + (d.value * 10) + ")";
   })
	//Tooltip
	.on("mouseover", function(d) {
		//Get this bar's x/y values, then augment for the tooltip
		var xPosition = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand() / 2;
		var yPosition = parseFloat(d3.select(this).attr("y")) + 14;
		
		//Update Tooltip Position & value
		d3.select("#tooltip")
			.style("left", xPosition + "px")
			.style("top", yPosition + "px")
			.select("#value")
			.text(d.value);
		d3.select("#tooltip").classed("hidden", false)
	})
	.on("mouseout", function() {
		//Remove the tooltip
		d3.select("#tooltip").classed("hidden", true);
	})	;
//Create labels
svg.selectAll("text")
   .data(dataset, key)
   .enter()
   .append("text")
   .text(function(d) {
		return d.value;
   })
   .attr("text-anchor", "middle")
   .attr("x", function(d, i) {
		return xScale(i) + xScale.rangeBand() / 2;
   })
   .attr("y", function(d) {
		return h - yScale(d.value) + 14;
   })
   .attr("font-family", "sans-serif") 
   .attr("font-size", "11px")
   .attr("fill", "white");
   
var sortOrder = false;
var sortBars = function () {
    sortOrder = !sortOrder;
    
    sortItems = function (a, b) {
        if (sortOrder) {
            return a.value - b.value;
        }
        return b.value - a.value;
    };
    svg.selectAll("rect")
        .sort(sortItems)
        .transition()
        .delay(function (d, i) {
        return i * 50;
    })
        .duration(1000)
        .attr("x", function (d, i) {
        return xScale(i);
    });
    svg.selectAll('text')
        .sort(sortItems)
        .transition()
        .delay(function (d, i) {
        return i * 50;
    })
        .duration(1000)
        .text(function (d) {
        return d.value;
    })
        .attr("text-anchor", "middle")
        .attr("x", function (d, i) {
        return xScale(i) + xScale.rangeBand() / 2;
    })
        .attr("y", function (d) {
        return h - yScale(d.value) + 14;
    });
};
// Add the onclick callback to the button
                                        
 //                               });






//barchart2 start
$("#senti").append("<h2>Sentiment Scores of Pos , Neg and Objective words</h2> <br>")
var dataset2 = data[4];



   var w = 1500;
        var h = 500;
        //var dataset = [ { key: 0, value: 5 },{ key: 1, value: 10 },{ key: 2, value: 13 },{ key: 3, value: 19 },{ key: 4, value: 21 },{ key: 5, value: 25 },{ key: 6, value: 22 },{ key: 7, value: 18 },{ key: 8, value: 15 },{ key: 9, value: 13 },{ key: 10, value: 11 },{ key: 11, value: 12 },{ key: 12, value: 15 },{ key: 13, value: 20 },{ key: 14, value: 18 },{ key: 15, value: 17 },{ key: 16, value: 16 },{ key: 17, value: 18 },{ key: 18, value: 23 },{ key: 19, value: 25 } ];
var xScale = d3.scale.ordinal()
				.domain(d3.range(dataset2.length))
				.rangeRoundBands([0, w], 0.10); 
var yScale = d3.scale.linear()
				.domain([0, d3.max(dataset2, function(d) {return d.value;})])
				.range([0, h]);
var key = function(d) {
	return d.key;
};
//Create SVG element
var svg = d3.select("span")
			.append("svg")
			.attr("width", w)
			.attr("height", h);
//Create bars
svg.selectAll("rect")
   .data(dataset2, key)
   .enter()
   .append("rect")
   .attr("x", function(d, i) {
		return xScale(i);
   })
   .attr("y", function(d) {
		return h - yScale(d.value);
   })
   .attr("width", xScale.rangeBand())
   .attr("height", function(d) {
		return yScale(d.value);
   })
   .attr("fill", function(d) {
		return "rgb(0, 0, " + (d.value * 10) + ")";
   })
	//Tooltip
	.on("mouseover", function(d) {
		//Get this bar's x/y values, then augment for the tooltip
		var xPosition = parseFloat(d3.select(this).attr("x")) + xScale.rangeBand() / 2;
		var yPosition = parseFloat(d3.select(this).attr("y")) + 14;
		
		//Update Tooltip Position & value
		d3.select("#tooltip")
			.style("left", xPosition + "px")
			.style("top", yPosition + "px")
			.select("#value")
			.text(d.value);
		d3.select("#tooltip").classed("hidden", false)
	})
	.on("mouseout", function() {
		//Remove the tooltip
		d3.select("#tooltip").classed("hidden", true);
	})	;
//Create labels
svg.selectAll("text")
   .data(dataset2, key)
   .enter()
   .append("text")
   .text(function(d) {
		return d.value;
   })
   .attr("text-anchor", "middle")
   .attr("x", function(d, i) {
		return xScale(i) + xScale.rangeBand() / 2;
   })
   .attr("y", function(d) {
		return h - yScale(d.value) + 14;
   })
   .attr("font-family", "sans-serif") 
   .attr("font-size", "11px")
   .attr("fill", "white");
   
var sortOrder = false;
var sortBars = function () {
    sortOrder = !sortOrder;
    
    sortItems = function (a, b) {
        if (sortOrder) {
            return a.value - b.value;
        }
        return b.value - a.value;
    };
    svg.selectAll("rect")
        .sort(sortItems)
        .transition()
        .delay(function (d, i) {
        return i * 50;
    })
        .duration(1000)
        .attr("x", function (d, i) {
        return xScale(i);
    });
    svg.selectAll('text')
        .sort(sortItems)
        .transition()
        .delay(function (d, i) {
        return i * 50;
    })
        .duration(1000)
        .text(function (d) {
        return d.value;
    })
        .attr("text-anchor", "middle")
        .attr("x", function (d, i) {
        return xScale(i) + xScale.rangeBand() / 2;
    })
        .attr("y", function (d) {
        return h - yScale(d.value) + 14;
    });
};
// Add the onclick callback to the button
d3.select("#sort").on("click", sortBars);
d3.select("#reset").on("click", reset);
                                        
                                });






//barchart2 end



                       // end of function
                });
//            });
          });

</script>
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
				<div >
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
<div class="container">
 
        <div class="jumbotron">
 
<svg id="visualisation" width="1000" height="500"></svg>
        </div>
    </div>
<input type="button" id="sort" class="btn"><br>
<input type="button" id="reset" class="btn"><br>
<span id="senti"></span>
 

<script>
                function InitChart(data,data2,data3) {
                    var vis = d3.select("#visualisation"),
                        WIDTH = 1400,
                        HEIGHT = 600,
                        MARGINS = {
                            top: 20,
                            right: 20,
                            bottom: 20,
                            left: 50
                        },
                        xScale = d3.scale.linear().range([MARGINS.left, WIDTH - MARGINS.right]).domain([0, 10000]),
                        yScale = d3.scale.linear().range([HEIGHT - MARGINS.top, MARGINS.bottom]).domain([0, 1]),
                        xAxis = d3.svg.axis()
                        .scale(xScale),
                        yAxis = d3.svg.axis()
                        .scale(yScale)
                        .orient("left");
                    
                    vis.append("svg:g")
                        .attr("class", "x axis")
                        .attr("transform", "translate(0," + (HEIGHT - MARGINS.bottom) + ")")
                        .call(xAxis);
                    vis.append("svg:g")
                        .attr("class", "y axis")
                        .attr("transform", "translate(" + (MARGINS.left) + ",0)")
                        .call(yAxis);
                    var lineGen = d3.svg.line()
                        .x(function(d) {
                            return xScale(d.word);
                        })
                        .y(function(d) {
                            return yScale(d.score);
                        })
                        .interpolate("basis");
                    vis.append('svg:path')
                        .attr('d', lineGen(data))
                        .attr('stroke', 'green')
                        .attr('stroke-width', 2)
                        .attr('fill', 'none');
                    vis.append('svg:path')
                        .attr('d', lineGen(data2))
                        .attr('stroke', 'red')
                        .attr('stroke-width', 2)
                        .attr('fill', 'none');
                    vis.append('svg:path')
                        .attr('d', lineGen(data3))
                        .attr('stroke', 'blue')
                        .attr('stroke-width', 2)
                        .attr('fill', 'none');

                }
            </script>

    <script src="/static/jquery.min.js"></script>
    <script src="/static/bootstrap.min.js"></script>
    <script src="/static/scripts.js"></script>
  </body>
</html>

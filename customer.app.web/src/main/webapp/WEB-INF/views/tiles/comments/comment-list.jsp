<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function() {
		var actionUrl = webContextPath + "/comments/records";
		$("#grid").jqGrid(
				{
					url : actionUrl,
					datatype : 'json',
					mtype : 'GET',
					hidegrid: false, 
					colNames : [ "Comment ID","Article Title", "Comment", "Username",
							"Create At"],
					colModel : [ {
						name : 'id',
						index : 'id',
						width : 75,
						hidden : true,
						frozen : true
					}, {
						name : 'article.title',
						index : 'article.title',
						width : 200,
						frozen : true,
						formatter:commentHyperLinkFormatter
					}, {
						name : 'comment',
						index : 'comment',
						width : 400,
						frozen : true
					},{
						name : 'user.userName',
						index : 'user.userName',
						width : 100,
						frozen : true
					},{
						name : 'createdAt',
						index : 'createdAt',
						width : 120,
						frozen : true
					}],
					rowNum : 20,
					rowList : [ 20, 30, 40, 50 ],
					height : 460,
					width : 900,
					pager : '#pager',
					rownumbers : true,
					sortname : 'createdAt',
					viewrecords : true,
					sortorder : "desc",
					caption : "Article Comments",
					emptyrecords : "Empty records",
					shrinkToFit : false,
					jsonReader : {
						repeatitems : false,
					}
				});

		$("#grid").jqGrid('navGrid', '#pager', {
			edit : false,
			add : false,
			del : false,
			search : true,
			excel : true,
		    searchtext: "Filter",
		    searchtitle: "Filter",
		    refreshtext: "Refresh",
		    refreshtitle: "Refresh"
		}, {}, {}, {}, { //search
			sopt : [ 'cn', 'eq', 'ne', 'lt', 'gt', 'bw', 'ew' ],
			closeOnEscape : true,
			multipleSearch : true,
			closeAfterSearch : false
		});
		$("#grid").jqGrid('setFrozenColumns');
	});
function commentHyperLinkFormatter (cellvalue, options, rowObject){
	var value = '<a href="javascript:void(0);" onclick="javascript:loadCommentDetails('+rowObject.id+')">'+ cellvalue +'</a>';
	return value;
}
function loadCommentDetails(commentId){
	 $.ajax({
		    url: webContextPath+"/comments/view/"+commentId,
		    dataType:'html',
		    success: function(data){
		      //construct the data however, update the HTML of the popup div 
		      $('#viewCommentsDiv').html(data);
		      $('#viewCommentsDiv').dialog({
		  		modal: 'true',
		  		height:700,
		  		width:850,
		  		closeOnEscape: true,
		  		buttons: [ { text: "Approve", click: function() {
			  					initiateActionOnCommentRecord(commentId,1);
				  				$( this ).dialog( "close" ); 
			  				} 
		  				},
		  				{ text: "Reject", click: function(){
		  					initiateActionOnCommentRecord(commentId,0);
		  					$( this ).dialog( "close" ); 
		  				} 
		  			}]
		      }).show();
		    }
		  });
}

function initiateActionOnCommentRecord(commentId,type){
	 $.ajax({
		    type:"post",
		    url: webContextPath+"/comments/approve/"+commentId+"/"+type,
		    success: function(data){
		    	showToastSuccessMessage("Record updated sucessfully.");
		    	$("#grid").trigger('reloadGrid');
		    },
		    error:function(jqXHR,textStatus,errorThrown){
		    	showToastErrorMessage("Record updating failed.");
		    }
	 });
}
</script>
</head>
<body>
<div style="height: 575px;">
	<div id='jqgrid'>
		<table id='grid'></table>
		<div id='pager'></div>
	</div>
</div>
	<div id="viewCommentsDiv" title="Deposit Notification" style="margin:auto; width:80%">
  </div>	
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	$(function() {
		var actionUrl = webContextPath + "/article/records";
		$("#grid").jqGrid(
				{
					url : actionUrl,
					datatype : 'json',
					mtype : 'GET',
					hidegrid: false, 
					colNames : [ "Article ID", "Title", "Desciption",
							"Content", "Parent Article Id", "Create At",
							"Created By"],
					colModel : [ {
						name : 'id',
						index : 'id',
						width : 75,
						frozen : true
					}, {
						name : 'title',
						index : 'title',
						width : 75,
						frozen : true
					}, {
						name : 'desciption',
						index : 'desciption',
						width : 100,
						frozen : true
					},{
						name : 'content',
						index : 'content',
						width : 100,
						frozen : true
					},{
						name : 'parent_article_id',
						index : 'parent_article_id',
						width : 100,
						frozen : true
					},{
						name : 'created_at',
						index : 'created_at',
						width : 100,
						frozen : true
					},{
						name : 'created_by',
						index : 'created_by',
						width : 100,
						frozen : true
					}],
					rowNum : 20,
					rowList : [ 20, 30, 40, 50 ],
					height : 450,
					width : 900,
					pager : '#pager',
					rownumbers : true,
					sortname : 'createdAt',
					viewrecords : true,
					sortorder : "desc",
					caption : "Routine Visit Report",
					emptyrecords : "Empty records",
					shrinkToFit : false,
					jsonReader : {
						repeatitems : false,
					}
				});

		function datePick(elem) {
			$(elem).datepicker({
				dateFormat : "dd-mm-yy"
			});
		}

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

		$("#grid").navButtonAdd('#pager', {
			caption : "Export",
			buttonicon : "ui-icon-newwin",
			onClickButton : exportExcel,
			position : "last",
			title : "",
			cursor : "pointer"
		});
		$("#grid").jqGrid('setFrozenColumns');
		
	});
	function exportExcel() {
		jQuery("#grid").jqGrid('excelExport', {
			tag : 'excel',
			url : webContextPath + '/routine/export'
		});
	}
</script>
</head>
<body>
<div style="height: 550px;">
	<div id='jqgrid'>
		<table id='grid'></table>
		<div id='pager'></div>
	</div>
</div>
	<div id='msgbox' title='' style='display: none'></div>
</body>
</html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false"%>
<html>
<spring:url value="/resources/css/screen.css" var="resourceCmxUrl"/>
<link href="${resourceCmxUrl}" rel="stylesheet" type="text/css" />
<head>
<script type="text/javascript">
var selectedParentId;
var selectedHrefUrl = "";
	$(document).ready(function() {	
		selectedParentId="";
		$("#articleForm").validate( {
		    success : "valid",
		    ignoreTitle : true,
		    rules : {
				"title" : {
			        required : true
			   },
				"content" : {
			        required : true
		      }	    
		   }
		});

		$("#save").button();
		$("#reset").button();
		$( "#parentArticleId").change(function() {
			selectedParentId = $(this).find("option:selected").val();  
			selectedHrefUrl= webContextPath + "/article/rest/parentIdData" + "/"+selectedParentId ;
		});
	});
	function submitArticle() {
		var saved = $("#save").attr("disabled");
		if (saved == 'disabled') {
			return;
		}
		var isValid = $("#articleForm").valid();
		console.log('Form Valid...', isValid);
		if (isValid) {
			console.log("..posting..."+(webContextPath + "/article/save"));
			$("#articleForm").attr("action",webContextPath + "/article/save");
		}
	}

	function refreshArticle() {
		location.reload();
	}
	
	function loadArticleContents(){
		//console.log('..webContextPath+"/mypage/jobdetail"',webContextPath+"/mypage/jobdetail");
		console.log(selectedHrefUrl,"...",selectedParentId);
		if(selectedParentId == ""){
			showToastErrorMessage("Select an article from the list to preview.");
		}else{
		$.ajax({
			    url: selectedHrefUrl,
			    dataType:'html',
			    success: function(data){
			      //construct the data however, update the HTML of the popup div 
			      $('#articleDetails').html(data);
			      $('#articleDetails').dialog({
			  		modal: 'true',
			  		height:400,
			  		width:470,
			  		closeOnEscape: true
			  	  }).show();
			    }
			  }); 
		}
	}
</script>
<style type="text/css">

#articleForm { width: 900px; }
#articleForm label.error {
	margin-left: 10px;
	width: auto;
	display: inline;
}

</style>
</head>

<body>
<form:form id="articleForm" name="articleForm" modelAttribute="articleForm" enctype="multipart/form-data" method="POST" cssClass="cmxform">
		<fieldset>
				<p>
					<label><em>*</em> <spring:message code="label.article.title"/> </label> 
					<form:input path="title"/>
				</p>
				<p>
					<label><em>*</em> <spring:message code="label.article.contents"/></label> 
					<form:textarea path="content" cols="60" rows="5"/>
				</p>
				<p>
					<label><spring:message code="label.article.description"/> </label> 
					<form:textarea path="description" cols="60" rows="5"/>
				</p>
				<p>
					<label><spring:message code="label.article.image"/></label> 
					<input type="file" name="imageFile"/>
				</p>
				<p>
					<label><spring:message code="label.article.parentArticleId"/></label> 
					<form:select path="parentArticleId" items="${previousArticle}"></form:select>
					<a id="viewDetailsLink" onclick="javascript:loadArticleContents();">View Details</a>
				</p>
		</fieldset>
			<button id="save" onclick="submitArticle();"><spring:message code="label.save"/> </button>
			<button id="reset" onclick="refreshArticle();"><spring:message code="label.reset"/></button>
			<span id="messageSpanId" class="message"></span>
	</form:form>
	<div id="articleDetails" title="Article Details"></div>
</body>
</html>

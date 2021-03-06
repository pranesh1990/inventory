 <%--
 *  Copyright 2009 Society for Health Information Systems Programmes, India (HISP India)
 *
 *  This file is part of Inventory module.
 *
 *  Inventory module is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.

 *  Inventory module is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Inventory module.  If not, see <http://www.gnu.org/licenses/>.
 *
--%> 
<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="View mainstore" otherwise="/login.htm" redirect="/module/inventory/main.form" />

<spring:message var="pageTitle" code="inventory.indentItem.manage" scope="page"/>

<%@ include file="/WEB-INF/template/header.jsp" %>

<%@ include file="nav.jsp" %>
<script>
	jQuery(document).ready(function(){
		jQuery('.date-pick').datepicker({minDate: '-100y', dateFormat: 'dd/mm/yy'});
	});
</script>
<h2><spring:message code="inventory.indentItem.manage"/></h2>	

<br />
<c:forEach items="${errors.allErrors}" var="error">
	<span class="error"><spring:message code="${error.defaultMessage}" text="${error.defaultMessage}"/></span><
</c:forEach>


<br /><br />
<form method="get"  id="form">


<table >
	<tr>
		<td valign="top"><spring:message code="inventory.store.store"/></td>
		<td>
			<select name="storeId" style="width:200px;">
	    	    <option value=""><spring:message code="inventory.pleaseSelect"/></option>
				<c:forEach items="${listStore}" var="store">
					<option value="${store.id}"
					<c:if test="${store.id == storeId}"> selected</c:if>
					>${store.name}</option>
				</c:forEach>
	   		</select>
		</td>
		<td><spring:message code="inventory.indentItem.status"/></td>
		<td>
			<select name="statusId" >
      		<option value=""><spring:message code="inventory.pleaseSelect"/></option>
			<c:forEach items="${listMainStoreStatus}" var="status">
				<option value="${status.id}" 
				<c:if test="${status.id == statusId }">selected</c:if>
				>${status.name}</option>
			</c:forEach>
	   </select>
		<td><spring:message code="inventory.indentItem.name"/></td>
		<td><input type="text" id="indentName" name="indentName" value="${indentName}" /></td>
		<td><spring:message code="inventory.fromDate"/></td>
		<td><input type="text" id="fromDate" class="date-pick left" readonly="readonly" name="fromDate" value="${fromDate}" title="Double Click to Clear" ondblclick="this.value='';"/></td>
		<td><spring:message code="inventory.toDate"/></td>
		<td><input type="text" id="toDate" class="date-pick left" readonly="readonly" name="toDate" value="${toDate}" title="Double Click to Clear" ondblclick="this.value='';"/></td>
		<td><input type="submit" class="ui-button ui-widget ui-state-default ui-corner-all" value="Search" /></td>
	</tr>
</table>

<span class="boxHeader"><spring:message code="inventory.indentItem.list"/></span>
<div class="box">
<c:choose>

<c:when test="${not empty listIndent}">
<table width="100%" cellpadding="0" cellspacing="0">
<tr align="center">
	<th >S.No</th>
	<th align="center" ><spring:message code="inventory.indentItem.fromStore"/></th>
	<th align="center" >Indent Name</th>
	<th align="center" ><spring:message code="inventory.indentItem.createdOn"/></th>
	<th align="center" ><spring:message code="inventory.indentItem.status"/></th>
	<th></th>
	
</tr>
<c:forEach items="${listIndent}" var="indent" varStatus="varStatus">
	<tr align="center" class='${varStatus.index % 2 == 0 ? "oddRow" : "evenRow" } '>
		<td><c:out value="${(( pagingUtil.currentPage - 1  ) * pagingUtil.pageSize ) + varStatus.count }"/></td>
		<td>${indent.store.name}</td>
		<td align="center"><a href="#" title="Detail indent" onclick="INDENT.detailItemIndent('${ indent.id}');">${indent.name}</a> </td>
		<td align="center"><openmrs:formatDate date="${indent.createdOn}" type="textbox"/> </td>
		<td align="center">${indent.mainStoreStatusName} </td>
		<td>
		<c:if test="${indent.mainStoreStatus == 1 }">
			<a href="#" onclick="ACT.go('mainStoreItemProcessIndent.form?indentId=${ indent.id}');"><spring:message code="inventory.indentItem.process"/></a>
		</c:if>
		</td>
	</tr>
</c:forEach>






<tr class="paging-container">
	<td colspan="8"><%@ include file="../paging.jsp" %></td>
</tr>
</table>
<br>
<div id="divDetailIndent"></div>

</c:when>
<c:otherwise>
	No indent found.
</c:otherwise>

</c:choose>
</div>
</form>
<%@ include file="/WEB-INF/template/footer.jsp" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="/WEB-INF/wma.tld" prefix="wma" %>

<form id="msg-list-form">
	<input type="hidden" id="path" name="path" value="<c:out value='${path}'/>" />
<c:if test="${not empty unread}">
	<input type="hidden" id="inbox-unread" value="${unread}"/>
</c:if>
<c:if test="${path == prefs.draftFolder}">
	<input type="hidden" id="draft" />
</c:if>
	<input type="hidden" id="page" name="page" value="<c:out value='${pager.pageNumber}'/>" />
	<input type="hidden" id="order" name="order" value="<c:out value='${param["order"]}'/>" />
	<input type="hidden" id="asc" name="asc" value="<c:out value='${pager.ascending}'/>" />
	<input type="hidden" name="_criteria" value="<c:out value='${param["criteria"]}' default='subject'/>" />
	<input type="hidden" name="_term" value="<c:out value='${term}'/>" />
	<div class="mail-header">
		<div class="pull-right form-inline">
			<select name="criteria" class="form-control input-sm">
		        <option value="subject"><fmt:message key="label.subject"/></option>
		        <option value="from"><fmt:message key="label.from"/></option>
		        <option value="to"><fmt:message key="label.to"/></option>
		        <option value="all"><fmt:message key="menu.filter.all"/></option>
		        <option value="unread"><fmt:message key="menu.filter.unread"/></option>
		        <option value="flagged"><fmt:message key="menu.filter.flagged"/></option>
			</select>
			<div class="form-group">
				<input type="text" class="form-control input-sm" name="term" placeholder="Search"/>
            	<button type="submit" class="btn btn-sm btn-primary"><i class="fa fa-search"></i></button>
			</div>
		</div>
		<a id="refresh" class="btn btn-default btn-sm"><i class="fa fa-refresh"></i></a>
<c:if test="${path == 'INBOX'}">
		<div class="btn-group" data-toggle="buttons">
	<c:choose>
		<c:when test="${not empty param['thread']}">
			<label class="btn btn-default btn-sm active">
				<input id="thread" name="thread" value="REFERENCES" type="checkbox" checked><i class="fa fa-comments"></i>
			</label>
		</c:when>
		<c:otherwise>
			<label class="btn btn-default btn-sm">
				<input id="thread" name="thread" value="REFERENCES" type="checkbox"><i class="fa fa-comments"></i>
			</label>
		</c:otherwise>
	</c:choose>
		</div>
</c:if>
<c:if test="${path != prefs.trashFolder}">
		<a id="purge" class="btn btn-default btn-sm"><fmt:message key="menu.purge"/></a>
</c:if>
		<a id="delete" class="btn btn-default btn-sm"><fmt:message key="menu.delete"/></a>
<c:if test="${path != prefs.draftFolder && path != prefs.sentMailArchive && path != prefs.trashFolder}">
		<a id="read" class="btn btn-default btn-sm"><fmt:message key="menu.read"/></a>
</c:if>
<c:if test="${path == prefs.sentMailArchive}">
		<a id="revoke" class="btn btn-default btn-sm"><fmt:message key="menu.revoke"/></a>
</c:if>
<c:if test="${path == 'INBOX'}">
		<a id="upload" class="btn btn-default btn-sm"><fmt:message key="menu.upload.eml"/></a>
</c:if>
<c:if test="${path != prefs.draftFolder}">
		<div class="btn-group">
			<a id="move" class="btn btn-default btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><fmt:message key="menu.move"/> <span class="caret"></span></a>
			<ul class="dropdown-menu"></ul>
		</div>
</c:if>
	</div>
	<table id="msg-table" class="table table-hover table-condensed">
		<thead>
			<tr>
				<th class="chk"><input type="checkbox" id="checkall"/></th>
				<th class="star"></th>
<c:choose>
	<c:when test="${path == prefs.draftFolder || path == prefs.sentMailArchive || path == prefs.toSendFolder}">
				<th><fmt:message key="label.to"/></th>
	</c:when>
	<c:otherwise>
				<th class="from sort"><a id="sort-by-from"><fmt:message key="label.from"/></a></th>
	</c:otherwise>
</c:choose>
				<th class="sort text-center"><a id="sort-by-subject"><fmt:message key="label.subject"/></a></th>
				<th class="flag"></th>
<c:choose>
	<c:when test="${path == prefs.sentMailArchive || path == prefs.toSendFolder}">
				<th class="date sort text-center"><a id="sort-by-date"><fmt:message key="label.sentdate"/></a></th>
	</c:when>
	<c:otherwise>
				<th class="date sort text-center"><a id="sort-by-arrival"><fmt:message key="label.receiveddate"/></a></th>
	</c:otherwise>
</c:choose>
			</tr>
		</thead>
		<tbody>
<c:if test="${not empty messages}">
	<c:forEach var="msg" items="${messages}">
		<c:choose>
			<c:when test="${msg.recent}"><tr class="recent unread"></c:when>
			<c:when test="${msg.read}"><tr></c:when>
			<c:otherwise><tr class="unread"></c:otherwise>
		</c:choose>				
				<td><input type="checkbox" name="uids" value="${msg.UID}"/></td>
				<td class="star"><i class="fa fa-lg fa-star<c:if test='${not msg.flagged}'>-o</c:if>"></i></td>
		<c:choose>
			<c:when test="${path == prefs.sentMailArchive}">
				<td><a href="#to"><wma:address value="${msg.to}" maxLength="1"/></a></td>
			</c:when>
			<c:when test="${path == prefs.draftFolder || path == prefs.toSendFolder}">
				<td><wma:address value="${msg.to}" maxLength="1"/></td>
			</c:when>
			<c:otherwise>
				<td><a href="#from"><wma:address value="${msg.from}"/></a></td>
			</c:otherwise>
		</c:choose>
				<td class="title">
					<c:if test="${not empty msg.conversations}"><i class="fa fa-plus-square"></i></c:if>
					<c:if test="${msg.answered}"><i class="fa fa-reply"></i></c:if>
					<a href="#open"><c:out value="${msg.subject}"/></a>
				</td>
				<td class="text-right">
		<c:if test="${msg.priority < 3}"><i class="fa fa-exclamation"></i></c:if>
		<c:if test="${msg.secure}"><i class="fa fa-lock"></i></c:if>
		<c:if test="${msg.multipart}"><i class="fa fa-paperclip"></i></c:if>
				</td>
				<td class="text-right">
		<c:choose>
			<c:when test="${path == prefs.sentMailArchive || path == prefs.toSendFolder}">
					<wma:date value="${msg.sentDate}"/>
			</c:when>
			<c:otherwise>
			<wma:date value="${msg.receivedDate}"/>
			</c:otherwise>
		</c:choose>
				</td>
			</tr>
	
		<c:if test="${not empty msg.conversations}">		
			<c:forEach var="cv" items="${msg.conversations}">
			<tr class="reply" style="display: none;">
				<td><input type="checkbox" name="uids" value="${cv.UID}"/></td>
				<td class="star"><i class="fa fa-lg fa-star<c:if test='${not cv.flagged}'>-o</c:if>"></i></td>
				<td><a href="#from"><wma:address value="${cv.from}"/></a></td>
				<td class="title"><i class="fa fa-caret-right"></i> <a href="#open"><c:out value="${cv.subject}"/></a></td>
				<td class="text-right"></td>
				<td class="text-right"><wma:date value="${cv.receivedDate}"/></td>
			</tr>
			</c:forEach>
		</c:if>
			
	</c:forEach>
</c:if>
<c:forEach begin="${fn:length(messages) + 1}" end="${pager.pageSize}">
		  	<tr>
		  		<td colspan="6">&nbsp;</td>
		  	</tr>
</c:forEach>
		</tbody>
	</table>
</form>
<div class="text-center">
	<ul class="pagination" id="pagination"></ul>
</div>
<form id="upload-form" action="message/upload" method="post" enctype="multipart/form-data" class="hidden">
	<input type="hidden" name="path" value="<c:out value='${path}'/>" />
	<input type="file" name="file" />
</form>
<script>
$(function() {
	console.log('messagelist');

	function secure( tr ) {
		return tr.find('i.fa-lock').length > 0;
	}

	function showMessage( tr, uid ) {
		addtab('tab-' + uid).load('message', $.param({path:$('#path').val(),uid:uid}), function() {
			tr.removeClass('recent unread');
    		showtab('tab-' + uid, $(this).find('.mail-title').text());
    	});
	}

	function showRecipients( uid, callback ) {
    	$('#modal')
			.find('.modal-header').hide().end()
			.find('.modal-body').html('<span class="fa fa-circle-o-notch fa-spin fa-3x text-primary"></span>')
	    		.load(
	    			'message/recipients?' + $.param({path:$('#path').val(), uid:uid}),
		    		callback
		    	).end()
	    	.modal('show');
    }

    function revoke( recipients ) {
		var $form = $('#modal').find('form'),
			param = $form.serializeArray(),
			status = ['OK', 'NOPERM', 'CANNOT', 'NONEXISTENT'];
		if (recipients) {
			param.push({name:'recipients', value:recipients});
		}
		$.post('message/revoke', param, function(data) {
			$.each(data, function(key, value) {
				var $tr = $form.find('a[href="#' + key + '"]').closest('tr');
				if ($tr.length) {
					$tr.children('td:last').text(status[value]);
				}
			});
		});
    }

    var $form = $('#msg-list-form'), path = $('#path').val(),
		$unread = $form.find('#inbox-unread');

	if ($unread.length == 1)
		$('#side-menu').find('#inbox-unread').text($unread.val());

	if ($('#thread').is(':checked'))
		$('#thread').parent().addClass('active');
	$('#thread').on('change', function() {
		$form.submit();
	});
	$('select[name=criteria]').val($('input[name=_criteria]').val());
	$('input[name=term]').val($('input[name=_term]').val());
	$('select[name=criteria]').on('change', function() {
		if ($.inArray($(this).val(),["all","unread","flagged"])>=0) {
			$('input[name=term]').val('');
			$form.submit();
		}
	});
	if ($('#order').val()) {
		$('#sort-by-' + $('#order').val()).parent()
			.removeClass('sort sort-asc sort-desc')
			.addClass(parseBool($('#asc').val()) ? 'sort-asc' : 'sort-desc');
	}

    $form.on('submit', function(event) {
		event.preventDefault(); event.stopPropagation();
		$('#page').val(0);
		refresh();
	}).on('click', '#checkall', function() {
		var b = this.checked;
		$form.find('input[name=uids]').each(function() {
			this.checked = b;
			this.checked ? $(this).closest('tr').addClass('checked') 
						 : $(this).closest('tr').removeClass('checked');
		});
    }).on('change', 'input[name=uids]', function() {
    	if (!$(this).is(':checked') && $('#checkall').is(':checked')) 
    		$('#checkall').prop('checked', false);
    	$(this).closest('tr').toggleClass('checked');
    }).on('click', 'a[href=#to]', function() {
    	var tr = $(this).closest('tr'),
    		uid = tr.find('input[name=uids]').val();
    	showRecipients(uid, function() {
    		$(this).find('a').on('click', function() {
    			revoke( $(this).attr('href').substring(1) );
    		});
    	});
    }).on('click', 'a[href=#open]', function() {
    	var tr = $(this).closest('tr'),
    		uid = tr.find('input[name=uids]').val();
    	if ($form.find('#draft').length != 0) {
    		$('#sub-tab').load('message/compose', $.param({path:$('#path').val(),uid:uid,draft:true}), function() { 
				showtab('sub-tab', $('#compose').text());
			});
    	} else {
	    	if (!showtab('tab-' + uid)) {
	    		if (!secure(tr)) showMessage(tr, uid);
	    		else {
	    			eModal.ajax({
						url: 'authcheck',
						title: 'Enter password',
						buttons: [
							{ text: 'Close', style: 'default', close: true },
							{ text: 'OK', style: 'primary', close: false, click: function() {
									var authform = $('#authcheck');
			    					$.post(authform.attr('action'), authform.serializeArray(), function(ok) {
			    						if (ok) {
			    							eModal.close();
			    							showMessage(tr, uid);
			    						} else {
			    							authform.find('.form-group').addClass('has-error').find('.error').removeClass('hidden').end().find('input[name=password]').focus();

			    						}
			    					}, 'json');
								}
							}
						]
	    			});
	    		}
	    	}
    	}
	}).on('click', '#delete, #purge', function(event) {
		if ($form.find('input[name=uids]:checked').length == 0) {
			eModal.alert('<fmt:message key="message.select"/>');
			return;
		}
		var purge = $(this).attr('id') === 'purge';
		eModal.confirm('<fmt:message key="message.confirm.delete"/>')
			.then(function() {
				var data = $form.serializeArray();
				data.push({name:'purge',value:purge});
				$.post('message/delete', data, function() {
					refresh();
				});
			});
	}).on('click', '#read', function(event) {
		var checked = $form.find('input[name=uids]:checked');
		if (checked.length == 0) {
			eModal.alert('<fmt:message key="message.select"/>');
			return;
		}
		var data = $form.serializeArray();
		data.push({name:'flag',value:'seen'});
		$.post('message/setflag', data, function() {
			checked.each(function() {
				$(this).prop('checked', false).closest('tr').removeClass('recent unread');
			});
		});
	}).on('click', '#revoke', function() {
		var checked = $form.find('input[name=uids]:checked');
		if (checked.length != 1) {
			eModal.alert('<fmt:message key="message.select"/>');
			return;
		}
	    showRecipients(checked.val(), function() {
	    	revoke();
    	});
	}).on('click', '#upload', function() {
		$('#upload-form :file').trigger('click');
	}).on('click', 'td.star', function() {
		var uid = $(this).closest('tr').find('input[name=uids]').val();
			star = $(this).find('.fa'),
			set = star.hasClass('fa-star-o');
		$.post('message/setflag', {path:$('#path').val(), uids:uid, flag:'flagged', set:set}, function() {
			star.removeClass('fa-star-o fa-star').addClass(set ? 'fa-star' : 'fa-star-o');
		});
	}).on('click', 'th > a[id]', function() {
		var id = $(this).attr('id'), n = id.lastIndexOf('-'),
			order = id.substring(n + 1);
		if ($('#order').val() == order) $('#asc').val($('#asc').val() != 'true');
		else $('#order').val(id.substring(n + 1));
		refresh();
	}).on('click', '.fa-plus-square, .fa-minus-square-o', function() {
		var that = $(this);
		    tr = that.closest('tr').next();
		if (that.hasClass('fa-plus-square')) 
			that.removeClass('fa-plus-square').addClass('fa-minus-square-o');
		else
			that.removeClass('fa-minus-square-o').addClass('fa-plus-square');
		while (tr.hasClass('reply')) {
			tr.toggle();
			tr = tr.next()
		}
	});
	$('#upload-form').on('change', ':file', function(event) {
		$.ajax({
			url: 'message/upload',
			data: new FormData($(event.delegateTarget)[0]),
			contentType: false,
			processData: false,
			cache: false,
			type: 'POST',
			success: function(data) {
				console.log(data);
			}
		});
		return false;
	});

	$('#move').parent().on('show.bs.dropdown', function(event) {
		var menu = $(this).find('.dropdown-menu');
		if (menu.children('li').length == 0) {
			var	psna = $('#personalArchive > a'),
				tree = $('#tree').fancytree('getTree');
			menu.append('<li><a href="#' + psna.data('target') + '">' + psna.text() + '</a></li>');
			$.each(tree.getRootNode().getChildren(), function(index, node) {
				menu.append($('<li><a href="#' + node.key + '">' + node.title + '</a></li>'));
			});
		}
	}).on('click', '.dropdown-menu a', function(event) {
		if ($form.find('input[name=uids]:checked').length == 0) {
			eModal.alert('<fmt:message key="message.select"/>');
			return;
		}
		var destfolder = $(this).attr('href').substring(1);
		if (destfolder === $('#path').val()) {
			return;
		}
		var data = $form.serializeArray();
		data.push({name:'destfolder',value:destfolder});
		$.post('message/move', data, function() {
			refresh();
		});
	});

    $('#pagination').pagination(<c:out value="${pager.itemCount}" />, {
    	items_per_page: <c:out value="${pager.pageSize}" />,
        current_page: $('#page').val(),
        callback: gotopage
    });
});
</script>
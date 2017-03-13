<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ page session="false" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="../../resources/css/style.css">
    <link rel="stylesheet" href="../../resources/bootstrap-3.3.7/css/bootstrap.min.css">
    <script src="../../resources/js/jquery-3.1.0.min.js"></script>
    <script src="../../resources/bootstrap-3.3.7/js/bootstrap.min.js"></script>
    <title>User Page</title>
</head>
<body>
<div class="container">
    <div class="useredit">
        <c:choose>
            <c:when test="${empty user.name}">
                <h1>
                    Add a User
                </h1>
            </c:when>
            <c:otherwise>
                <h1>
                    Edit User
                </h1>
            </c:otherwise>
        </c:choose>

        <c:url var="addAction" value="/user/add"></c:url>
        <form:form action="${addAction}" commandName="user">
            <c:if test="${!empty user.name}">
                <div class="form-group">
                    <form:label path="id">
                        <spring:message text="ID"/>
                    </form:label>
                    <form:input class="form-control" path="id" readonly="true" size="8" disabled="true"/>
                    <form:hidden path="id"/>
                </div>
            </c:if>
            <div class="form-group">
                <form:label path="name">
                    <spring:message text="Name"/>
                </form:label>
                <form:input class="form-control" path="name" required="true"/>
            </div>
            <div class="form-group">
                <form:label path="age">
                    <spring:message text="Age"/>
                </form:label>
                <form:input class="form-control" path="age"/>
            </div>
            <div class="form-group">
                <form:label path="admin">
                    <spring:message text="Admin Rights"/>
                </form:label>
                <form:checkbox class="checkbox" path="admin"/>
            </div>
            <c:if test="${!empty user.name}">
                <input class="btn btn-primary" type="submit"
                       value="<spring:message text="Edit User"/>"/>
                <a href="<c:url value='/users'/>" class="btn btn-primary">Cancel</a>
            </c:if>
            <c:if test="${empty user.name}">
                <input class="btn btn-primary" type="submit"
                       value="<spring:message text="Add User"/>"/>
            </c:if>

        </form:form>
    </div>
    <br>
    <h3>Users List</h3>
    <c:if test="${!empty listUsers}">
        <div class="row">
            <div class="panel panel-primary filterable">
                <div class="panel-heading">
                    <h3 class="panel-title">Users</h3>
                    <div class="pull-right">
                        <button class="btn btn-default btn-xs btn-filter"><span
                                class="glyphicon glyphicon-filter"></span> Filter
                        </button>
                    </div>
                </div>
                <table class="table table-striped">
                    <thead>
                    <tr class="filters">
                        <th><input type="text" class="form-control" placeholder="User ID" disabled></th>
                        <th><input type="text" class="form-control" placeholder="User Name" disabled></th>
                        <th><input type="text" class="form-control" placeholder="Age" disabled></th>
                        <th><input type="text" class="form-control" placeholder="Admin Rights" disabled></th>
                        <th><input type="text" class="form-control" placeholder="Created Date" disabled></th>
                        <th><input type="text" class="form-control" placeholder="Edit" disabled></th>
                        <th><input type="text" class="form-control" placeholder="Delete" disabled></th>
                    </tr>
                    </thead>
                    <tbody id="myTable">
                    <c:forEach items="${listUsers}" var="user">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.age}</td>
                            <td>${user.admin}</td>
                            <td>${user.createdDate}</td>
                            <td><a href="<c:url value='/edit/${user.id}' />" class="btn btn-primary btn-xs"><span class="glyphicon glyphicon-pencil"></span></a></td>
                            <td><button id="open-deleteDialog" class="btn btn-danger btn-xs" data-title="Delete" data-toggle="modal" data-target="#deleteDialog" value='/remove/${user.id}'><span class="glyphicon glyphicon-trash"></span></button></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-md-12 text-center">
            <ul class="pagination pagination-lg pager" id="myPager"></ul>
        </div>
    </c:if>
</div>

<div class="modal fade" id="deleteDialog" tabindex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"><span class="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                <h4 class="modal-title custom_align" id="Heading">Delete user</h4>
            </div>
            <div class="modal-body">

                <div class="alert alert-danger"><span class="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this user?</div>

            </div>
            <div class="modal-footer">
                <a id="userDeleteID" href="<c:url value="/remove/" />" class="btn btn-success"><span class="glyphicon glyphicon-ok-sign"></span> Yes</a>
                <button type="button" class="btn btn-default" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> No</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

<script type="text/javascript" language="javascript">

    $(document).on("click", "#open-deleteDialog", function () {
        debugger;
        var userDel = $(this).attr("value");
        $("#userDeleteID").attr("href", userDel);
    });

    $(document).ready(function () {
        $('.filterable .btn-filter').click(function () {
            var $panel = $(this).parents('.filterable'),
                    $filters = $panel.find('.filters input'),
                    $tbody = $panel.find('.table tbody');
            if ($filters.prop('disabled') == true) {
                $filters.prop('disabled', false);
                $filters.first().focus();
            } else {
                $filters.val('').prop('disabled', true);
                $tbody.find('.no-result').remove();
                $tbody.find('tr').show();
            }

            $('#myTable').pageMe({
                pagerSelector: '#myPager'
            });
        });

        $('.filterable .filters input').keyup(function (e) {
            /* Ignore tab key */
            var code = e.keyCode || e.which;
            if (code == '9') return;
            /* Useful DOM data and selectors */
            var $input = $(this),
                    inputContent = $input.val().toLowerCase(),
                    $panel = $input.parents('.filterable'),
                    column = $panel.find('.filters th').index($input.parents('th')),
                    $table = $panel.find('.table'),
                    $rows = $table.find('tbody tr');
            /* Dirtiest filter function ever ;) */
            var $filteredRows = $rows.filter(function () {
                var value = $(this).find('td').eq(column).text().toLowerCase();
                return value.indexOf(inputContent) != -1;
            });
            /* Clean previous no-result if exist */
            $table.find('tbody .no-result').remove();
            /* Show all rows, hide filtered ones (never do that outside of a demo ! xD) */
            $rows.hide();

            /* Prepend no-result row if all rows are filtered */

            if ($filteredRows.length === 0) {
                $table.find('tbody').prepend($('<tr class="no-result text-center"><td colspan="' + $table.find('.filters th').length + '">No result found</td></tr>'));
            }

            $('#myTable').pageMe({
                pagerSelector: '#myPager',
                listRows: $filteredRows
            });
        });


        $('#myTable').pageMe({
            pagerSelector: '#myPager'
        });
    });

    $.fn.pageMe = function (opts) {
        var $this = this,
                defaults = {
                    perPage: 5,
                    showPrevNext: true,
                    hidePageNumbers: false
                },
                settings = $.extend(defaults, opts);

        var perPage = settings.perPage;

        var children;
        if (typeof settings.listRows!="undefined") {
            children = settings.listRows;
        }
        else
        {
            children = $this.children();
        }

        var pager = $('.pager');


        if (typeof settings.pagerSelector != "undefined") {
            pager = $(settings.pagerSelector);
        }

        var numItems = children.length;
        var numPages = Math.ceil(numItems / perPage);

        pager.data("curr", 0);
        pager.empty();

        if (settings.showPrevNext) {
            $('<li><a href="#" class="prev_link">Previous</a></li>').appendTo(pager);
        }

        var curr = 0;
        while (numPages > curr && (settings.hidePageNumbers == false)) {
            $('<li><a href="#" class="page_link">' + (curr + 1) + '</a></li>').appendTo(pager);
            curr++;
        }

        if (settings.showPrevNext) {
            $('<li><a href="#" class="next_link">Next</a></li>').appendTo(pager);
        }


        pager.find('.page_link:first').addClass('active');
        pager.find('.prev_link').hide();

        if (numPages <= 1) {
            pager.find('.next_link').hide();
        }
        pager.children().eq(1).addClass("active");

        children.hide();
        children.slice(0, perPage).show();

        pager.find('li .page_link').click(function () {
            var clickedPage = $(this).html().valueOf() - 1;
            goTo(clickedPage, perPage);
            return false;
        });
        pager.find('li .prev_link').click(function () {
            previous();
            return false;
        });
        pager.find('li .next_link').click(function () {
            next();
            return false;
        });

        function previous() {
            var goToPage = parseInt(pager.data("curr")) - 1;
            goTo(goToPage);
        }

        function next() {
            goToPage = parseInt(pager.data("curr")) + 1;
            goTo(goToPage);
        }

        function goTo(page) {
            var startAt = page * perPage,
                    endOn = startAt + perPage;

            children.css('display', 'none').slice(startAt, endOn).show();

            if (page >= 1) {
                pager.find('.prev_link').show();
            }
            else {
                pager.find('.prev_link').hide();
            }

            if (page < (numPages - 1)) {
                pager.find('.next_link').show();
            }
            else {
                pager.find('.next_link').hide();
            }

            pager.data("curr", page);
            pager.children().removeClass("active");
            pager.children().eq(page + 1).addClass("active");

        }
    };


</script>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib prefix="html" tagdir="/WEB-INF/tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>论坛版块页面</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="description" content="">
    <meta name="viewport" content="width=device-width">

    <!-- Main Style Sheet -->
    <link rel="stylesheet" href="<c:url value="/css/main.css"/>">
    <!--<link href="css/signin.css" rel="stylesheet">-->
    <!-- Modernizr -->
    <script src="<c:url value="/js/vendor/modernizr-2.6.2.min.js" />"></script>

    <script src="<c:url value=" /js/vendor/respond.min.js" />"></script>
</head>
<body>

<script type="text/javascript" color="255,0,0" opacity='0.7' zIndex="-2" count="300" src="//cdn.bootcss.com/canvas-nest.js/1.0.1/canvas-nest.min.js"></script>


<header role="banner">
    <nav role="navigation" class="navbar navbar-default">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="<c:url value="/index.html"/> "><img src="<c:url value="/img/logo.png"/>" alt="ThisUsCommunity'" width="200px"></a>
            </div>
            <div class="navbar-collapse collapse">
                <ul class="nav navbar-nav">
                    <%--<li><a href="<c:url value="/index.html"/> "><span class="glyphicon glyphicon-home"></span>主页</a></li>--%>
                    <c:if test="${!empty USER_CONTEXT.userName}">
                        <li>
                               <a href="<c:url value="/login/doLogout.html"/>"><span class="glyphicon glyphicon-remove">${USER_CONTEXT.userName}(${USER_CONTEXT.credit}),注销${USER_CONTEXT.userType}</a>
                        </li>
                    </c:if>
                    <c:if test="${empty USER_CONTEXT.userName}">
                        <li><a href="<c:url value="/login.jsp"/>"><span class="glyphicon glyphicon-upload"></span>登录</a></li>
                        <li><a href="<c:url value="/register.jsp"/>"><span class="glyphicon glyphicon-plus"></span>注册</a></li>
                    </c:if>
                        <li class="active"><a href="<c:url value="/index.html"/>"><span class="glyphicon glyphicon-list-alt"></span>社区内容</a></li>
                    <c:if test="${USER_CONTEXT.userType==2}">
                        <li>
                            <a href="<c:url value="/forum/addBoardPage.html"/>"><span class="glyphicon glyphicon-edit"></span>新建版块</a>
                        </li>
                        <li>
                            <a href="<c:url value="/forum/setBoardManagerPage.html"/>"><span class="glyphicon glyphicon-user"></span>管理员设置</a>
                        </li>
                        <li>
                            <a href="<c:url value="/forum/userLockManagePage.html"/>"><span class="glyphicon glyphicon-lock"></span>用户锁定/解锁</a>
                        </li>
                    </c:if>
                </ul>
                <form class="navbar-form navbar-left" role="search" action="<c:url value="/forum/searchTopic.html"/>">
                    <div class="form-group">
                        <input type="text" class="form-control" placeholder="Search" name="topicName">
                    </div>
                    <button type="submit" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                </form>
            </div><!--/.nav-collapse -->
        </div><!--/.container -->
    </nav>
</header>

<%--<%@ include file="includeTop.jsp"%>--%>

<div class="panel panel-default">
    <!-- Default panel contents -->
    <div class="panel-heading">${board.boardName}</div>
    <div class="panel-body">
        <p>${board.boardDesc}</p>
    </div>

    <!-- Table -->
    <table class="table">
        <tr>
            <c:if test="${USER_CONTEXT.userType == 2 || isboardManager}">

            </c:if>
            <td colspan="3" bgcolor="#EEEEEE">板块帖子</td>

            <td colspan="3" bgcolor="#EEEEEE" align="right">
                <a
                        href="<c:url value="/board/addTopicPage-${board.boardId}.html"/>">发表新话题</a>
            </td>

        </tr>
        <tr>
            <c:if test="${USER_CONTEXT.userType == 2 || isboardManager}">
                <td>
                    <script>
                        function switchSelectBox(){
                            var selectBoxs = document.all("topicIds");
                            if(!selectBoxs) return ;
                            if(typeof(selectBoxs.length) == "undefined"){//only one checkbox
                                selectBoxs.checked = event.srcElement.checked;
                            }else{//many checkbox ,so is a array
                                for(var i = 0 ; i < selectBoxs.length ; i++){
                                    selectBoxs[i].checked = event.srcElement.checked;
                                }
                            }
                        }
                    </script>
                    <%--<input type="checkbox" onclick="switchSelectBox()"/>--%>
                </td>
            </c:if>
            <td width="40%">
                标题
            </td>
            <td width="10%">
                头像
            </td>
            <td width="10%">
                发表人
            </td>
            <td width="10%">
                回复数
            </td>
            <td width="15%">
                发表时间
            </td>
            <td width="15%">
                最后回复时间
            </td>
        </tr>
        <c:set var="isboardManager" value="${false}" />
        <c:forEach items="${USER_CONTEXT.manBoards}" var="manBoard">
            <c:if test="${manBoard.boardId == board.boardId}">
                <c:set var="isboardManager" value="${true}" />
            </c:if>
        </c:forEach>
        <c:forEach var="topic" items="${pagedTopic.result}">
            <tr>
                <c:if test="${USER_CONTEXT.userType == 2 || isboardManager}">
                    <td><input type="checkbox" name="topicIds" value="${topic.topicId}"/></td>
                </c:if>
                <td>
                    <a  href="<c:url value="/board/listTopicPosts-${topic.topicId}.html"/>">
                        <c:if test="${topic.digest > 0}">
                            <font color=red>★</font>
                        </c:if>
                            ${topic.topicTitle}
                    </a>

                </td>
                <td>
                    <c:if test="${!empty topic.user.avatar}">
                        <div >
                            <img  style="width: 50px;length:50px; line-height: 50px" src="<c:url value="${topic.user.avatar}"/> "/>
                        </div>
                    </c:if>
                </td>
                <td>
                        ${topic.user.userName}
                    <br>
                    <br>
                </td>
                <td>
                        ${topic.replies}
                    <br>
                    <br>
                </td>
                <td>
                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm"
                                    value="${topic.createTime}" />
                </td>
                <td>
                    <fmt:formatDate pattern="yyyy-MM-dd HH:mm"
                                    value="${topic.lastPost}" />
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<html:PageBar
        pageUrl="/board/listBoardTopics-${board.boardId}.html"
        pageAttrKey="pagedTopic"/>
<c:if test="${USER_CONTEXT.userType == 2 || isboardManager}">
    <script>
        function getSelectedTopicIds(){
            var selectBoxs = document.all("topicIds");
            if(!selectBoxs) return null;
            if(typeof(selectBoxs.length) == "undefined" && selectBoxs.checked){
                return selectBoxs.value;
            }else{//many checkbox ,so is a array
                var ids = "";
                var split = ""
                for(var i = 0 ; i < selectBoxs.length ; i++){
                    if(selectBoxs[i].checked){
                        ids += split+selectBoxs[i].value;
                        split = ",";
                    }
                }
                return ids;
            }
        }
        function deleteTopics(){
            var ids = getSelectedTopicIds();
            if(ids){
                var url = "<c:url value="/board/removeTopic.html"/>?topicIds="+ids+"&boardId=${board.boardId}";
                //alert(url);
                location.href = url;
            }
        }
        function setDefinedTopis(){
            var ids = getSelectedTopicIds();
            if(ids){
                var url = "<c:url value="/board/makeDigestTopic.html"/>?topicIds="+ids+"&boardId=${board.boardId}";
                location.href = url;
            }
        }
    </script>
    <input type="button" value="删除" onclick="deleteTopics()">
    <input type="button" value="置精华帖" onclick="setDefinedTopis()">
</c:if>


</body>
</html>

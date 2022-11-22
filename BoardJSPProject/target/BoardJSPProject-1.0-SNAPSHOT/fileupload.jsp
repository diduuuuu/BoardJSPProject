<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="com.example.*,java.io.File" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>파일 업로드 결과</title>
</head>
<body>
    <%
        String filename = ""; //업로드 되는 파일 이름 저장용
        int sizeLimit = 15 * 1024 * 1024; //파일크기는 15MB

        //실제로 서버에 저장되는 path를 upload로 정한다.
        String realPath = request.getServletContext().getRealPath("upload");

        //혹시 저장될 경로가 없다면 생성.
        File dir = new File(realPath);
        if(!dir.exists()) dir.mkdir();


        //파일 업로드를 처리하는 과정이다.
        //파라미터는 request, 파일 저장 경로, 최대 용량, 인코딩, 중복파일명에 대한 정책이다. 중복될 경우 뒤에 숫자 붙임.
        MultipartRequest multipartRequest = null;
        multipartRequest = new MultipartRequest(request, realPath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());

        //photo라는 이름으로 전송되어 업로드 된 파일 이름을 가져온다.
        filename = multipartRequest.getFilesystemName("photo");

    %>

    폼에서 전송된 원래 파일명 : <%=multipartRequest.getOriginalFileName("photo")%><br />
    업로드한 파일의 경로 : ${pageContext.request.contextPath }/upload/<%=filename%><br />
    물리적인 저장 경로 : <%=realPath%><br />
    <img src="${pageContext.request.contextPath}/upload/<%=filename%>">

    파일명: <%=filename%><br />
</body>
</html>


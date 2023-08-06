<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%
	if (session != null && session.getAttribute("loggedIn") != null) {
		// User is logged in

		// Check if the user is an admin
		String role = (String) session.getAttribute("role");
		if (!role.equals("admin")) {
			// User is a registered user
    Double totalPrice = (Double) request.getAttribute("totalPrice");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Order Details</title>
</head>
<body>
    <body>
    <h3 style='color: green;'>Order is Successful!</h3>
    <p>Amount Payed: <%=totalPrice %></p>
    <a href="ca1/home.jsp">Return to home page</a>
    
    <%
	} else {
	// User is not an admin
	response.sendRedirect("login.jsp"); // Redirect to the home page
	}
	} else {
	// User is not logged in
	response.sendRedirect("login.jsp"); // Redirect to the home page
	}
	%>
</body>
</html>
package BookServlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.json.Json;
import javax.json.JsonObject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.Response;

/**
 * Servlet implementation class UpdateBook
 */
@WebServlet("/UpdateBook")
public class UpdateBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateBook() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		Client client = ClientBuilder.newClient();
		String restUrl = "http://localhost:8081/store/books/updateBook";

		/*
		 * https://stackoverflow.com/questions/49600788/create-jax-rs-client-post-
		 * request-with-json-string-as-body
		 */
		JsonObject newBook = Json.createObjectBuilder().add("bookId", request.getParameter("bookId")).add("title", request.getParameter("title"))
				.add("author", request.getParameter("author")).add("genreId", request.getParameter("genreId"))
				.add("price", request.getParameter("price")).add("quantity", request.getParameter("quantity"))
				.add("publisher", request.getParameter("publisher")).add("publishDate", request.getParameter("publishDate"))
				.add("isbn", request.getParameter("isbn")).add("rating", request.getParameter("rating"))
				.add("description", request.getParameter("description")).add("imageLocation", request.getParameter("imageLocation"))
				.add("sold", request.getParameter("sold")).build();

		Response resp = client.target(restUrl).request().put(Entity.json(newBook));

		System.out.println("Status: " + resp.getStatus());

		if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
			System.out.println("Success");

			String rec = resp.readEntity(new GenericType<String>() {
			});

			request.setAttribute("rec", rec);
			String url = request.getContextPath() + "/ca1/adminDashboard.jsp";
			System.out.println(url);
			RequestDispatcher cd = request.getRequestDispatcher(url);
			cd.forward(request, response);
		} else {
			System.out.println("Failure");
			String url = "ca1/adminDashboard.jsp";
			request.setAttribute("err", "FailedInsertBook");
			RequestDispatcher cd = request.getRequestDispatcher(url);
			cd.forward(request, response);
		}
	}
	}



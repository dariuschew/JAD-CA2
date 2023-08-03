<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@page import="Country.*"%>
    <%@page import="City.*" %>
    <%@page import="Address.*" %>
    <%@ page import="java.util.List"%>
<%
AddressDao addressDao = new AddressDao();
CountryDao countryDao = new CountryDao();
CityDao cityDao = new CityDao();
int userId = (int) session.getAttribute("userId");
System.out.println(userId);
List<Address> addressList = addressDao.getAddressByUserId(userId);
System.out.println(addressList);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Checkout Form</title>
	<link rel="stylesheet" href="css/checkout.css">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
</head>
<body>


		<div class="col-md-4 container bg-default">
			<h4 class="my-4">Billing Address</h4>
			
			  <% if (addressList != null) { %>
            
            <form action="AddressServlet" method="GET">
               
                <% for (Address address : addressList) { %>
                    <input type="radio" name="selectedAddress" value="<%= address.getAddressId() %>">
                    <%= address.getAddress() %><br>
                <% } %>
                
                <button class="btn btn-primary bt-lg btn-block" type="submit">Continue to Payment</button>
            </form>
        <% } else { %>
			  <form action="AddressServlet" method="post">
				<div class="form-group">
					<label for="address">Address</label>
					<input type="text" class="form-control" id="adress" placeholder="1234 Main Street" required>
					<div class="invalid-feedback">
						Please enter your shipping address.
					</div>
				</div>

				<div class="form-group">
					<label for="address2">Address 2
						<span class="text-muted">(Optional)</span>
					</label>
					<input type="text" class="form-control" id="address2" placeholder="Flat No">
				</div>
				
					<div class="row">
					<div class="col-md-4 form-group">
							<label for="country">Country</label>
							<select class="form-control" id="countryId" name="countryId">
								<%
								List<Country> countryList = countryDao.getCountry();
								for(Country country : countryList) {
									City city = cityDao.getCountryId(country.getCountryId());
									 selected = country.getCountryId().equals(city.getCountryId()) ? "selected" : "";
								%>	
								<option value="<%=country.getCountryId() %>" <%=selected %>><%=country.getCountry() %></option>							
								<%	
								}
								%>
							</select>
							<div class="invalid-feedback">
								Please select a valid country.
							</div>	
						</div>
	
	<div class="col-md-4 form-group">
						<label for="city">City</label>
						<select class="form-control" id="cityId" name="cityId">
							<%
							List<City> cityList = cityDao.getCity(countryId);
							for(City city : cityList) {
							%>	
							<option value="<%=city.getCityId() %>" ><%=city.getCity() %></option>							
							<%
							}
							%>
						</select>
						<div class="invalid-feedback">
							Please provide a valid city.
						</div>
					</div>
</div>
				
			
				<div class="col-md-4 form-group">
						<label for="district">District</label>
					<input type="text" class="form-control" id="district" placeholder="Singapore" name="district">
						<div class="invalid-feedback">
							District required.
						</div>
					</div>
			
			
					
					
					<div class="row">
					<div class="col-md-6 form-group">
						<label for="postalCode">Postal Code</label>
						<input type="text" class="form-control" id="postalCode" placeholder="092342" name="postalCode">
						<div class="invalid-feedback">
							Valid postal code is required.
						</div>
					</div>

					<div class="col-md-6 form-group">
						<label for="phone">Phone Number</label>
						<input type="text" class="form-control" id="phone" placeholder="09009121" name="phone">
						<div class="invalid-feedback">
							Valid phone number is required.
						</div>
					</div>
				</div>

				<hr>
				
					<div class="form-check">
						<input type="checkbox" class="form-check-input" id="shipping-adress"> 
							Shipping address is the same as my billing address
						<label for="shipping-adress" class="form-check-label"></label>
					</div>

				<div class="form-check">
					<input type="checkbox" class="form-check-input" id="same-adress">
						Save this information for next time
					<label for="same-adress" class="form-check-label"></label>					
					</div>


				<hr>

					<hr class="mb-4">
						<button class="btn btn-primary bt-lg btn-block" type="submit">Continue to Payment</button>
						</form>
		<%
			}
%>			
		</div>
		
		
		
</body>
</html>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List" %>
<%@ page import="com.real.serviceimpl.PropertyDAO" %>

<%
HttpSession sdsession = request.getSession(true);

// Retrieve the username attribute from the session
String username = (String) sdsession.getAttribute("username");
String roleIDString = (String) sdsession.getAttribute("RoleID");

// Check if the user is logged in or redirect to the login page
if (roleIDString == null) {
    response.sendRedirect("login.jsp"); // Change "login.jsp" to your actual login page
} else {
    // Rest of your content for the logged-in user
%>

<!DOCTYPE html>
<html lang="en">
	    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
        <meta name="description" content="Smarthr - Bootstrap Admin Template">
		<meta name="keywords" content="admin, estimates, bootstrap, business, corporate, creative, management, minimal, modern, accounts, invoice, html5, responsive, CRM, Projects">
        <meta name="author" content="Dreamguys - Bootstrap Admin Template">
        <meta name="robots" content="noindex, nofollow">
        <title>Homex - Real Estate Template</title>
		
		<!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="admin/assets/img/favicon.png">
		
		<!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
		
		<!-- Fontawesome CSS -->
        <link rel="stylesheet" href="css/font-awesome.min.css">
		
		<!-- Lineawesome CSS -->
        <link rel="stylesheet" href="css/line-awesome.min.css">
		
		<!-- Select2 CSS -->
		<link rel="stylesheet" href="css/select2.min.css">
		
		<!-- Datetimepicker CSS -->
		<link rel="stylesheet" href="css/bootstrap-datetimepicker.min.css">
		
		<!-- Main CSS -->
        <link rel="stylesheet" href="css/style.css">
        
		 <link rel="stylesheet" href="css/tstyles.css">
		
		 <style>
        #itemTable {
            max-height: 300px; /* Adjust the maximum height as needed */
            overflow-y: auto;
        }
        .disabled-link {
			    color: gray; /* Change the text color to gray */
			    pointer-events: none; /* Remove pointer events, making it non-clickable */
			}
			.button-row {
    display: flex;
    justify-content: space-between;
}

.delete-button, .add-button {
    cursor: pointer;
    padding: 5px 10px;
    background-color: white;
    border: 1px solid #aaa;
    margin: 5px;
}

.delete-button:disabled {
    opacity: 0.5;
    cursor: not-allowed;
}
			
    </style>
	    <script>
	    // Function to fetch and display property details based on the selected property ID
	    function showPropertyDetails() {
	        // Get the selected property ID from the dropdown
	        var selectedPropertyId = $('[name="id"]').find(":selected").val();
			console.log("in showpropertydetails");
	        // Make an AJAX request to the server-side endpoint with the selected property ID
	        $.ajax({
	            type: 'GET',
	            url: 'PropertyDetailsServlet?propertyId=' + selectedPropertyId,
	            dataType: 'json',
	            success: function (data) {
	                // Populate the form fields with the retrieved property details
	                $('[name="pname"]').val(data.propertyName);
	                $('[name="pmobile"]').val(data.mobileNumber);
	                $('[name="Status"]').val(data.status);
	                $('[name="type"]').val(data.type);
	                $('[name="age"]').val(data.age);
	                $('[name="dimensions"]').val(data.dimensions);
	                $('[name="city"]').val(data.city);
	                $('[name="highlights"]').val(data.highlights);
	                $('[name="amenities"]').val(data.amenities);
	                $('[name="price"]').val(data.price);
	                $('[name="listeddate"]').val(data.listedDate);
	                $('[name="ishighlight"]').val(data.isHighlighted);
	               
	                
	                // ... Add more fields as needed ...
	
	                // Update the table with property features if available
	                updatePropertyFeatures(data.features);
	            },
	            error: function (error) {
	                console.error('Error fetching property details:', error);
	            }
	        });
	    }
	
	    // Function to update the property features table
	    function updatePropertyFeatures(features) {
	        // Clear existing table rows
	        $('#propertyfeature tbody').empty();
	
	        // Iterate through features and add rows to the table
	        for (var i = 0; i < features.length; i++) {
	            var rowHtml = '<tr>';
	            rowHtml += '<td>' + features[i].id + '</td>';
	            rowHtml += '<td><select name="featurename" class="form-control" style="min-width:250px">' +
	                        '<option value="gym">Gym</option>' +
	                        '<option value="swimmingpool">Swimming Pool</option>' +
	                        '<option value="sportsclub">Sports Club</option>' +
	                        '<option value="Security">Security</option>' +
	                        '<option value="Garden">Garden</option>' +
	                        '</select></td>';
	            rowHtml += '<td><input name="typename" class="form-control" style="min-width:500px" type="text" value="' + features[i].typeName + '"></td>';
	            rowHtml += '</tr>';
	
	            $('#propertyfeature tbody').append(rowHtml);
	        }
	    }
	
	    // Attach the showPropertyDetails function to the change event of the property ID dropdown
	    $('[name="id"]').change(function () {
	        showPropertyDetails();
	    });
	
	    // Trigger the showPropertyDetails function on page load (if an initial property ID is selected)
	    showPropertyDetails();
	</script>
    </head>
    
    <body>
    <form action="./EditPropertyServlet" method="post">
		<!-- Main Wrapper -->
        <div class="main-wrapper">
		
			<!-- Header -->
        <!-- Include your header HTML here -->
         <jsp:include page="header.jsp" />

        <!-- Sidebar -->
        <!-- Include your sidebar HTML here -->
        <jsp:include page="sidebar.jsp" />
			<!-- /Sidebar -->
			
			<!-- Page Wrapper -->
            <div class="page-wrapper">
			
				<!-- Page Content -->
                <div class="content container-fluid">
				
					<!-- Page Header -->
					<div class="page-header">
						<div class="row">
							<div class="col-sm-12">
								<h3 class="page-title">Edit Property</h3>
								<ul class="breadcrumb">
									<li class="breadcrumb-item"><a href="index.jsp">Dashboard</a></li>
									<li class="breadcrumb-item active">Edit Property</li>
								</ul>
							</div>
						</div>
					</div>
					<!-- /Page Header -->					
					<div class="row">
						<div class="col-sm-12">
								<div class="row">
								<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>ID <span class="text-danger">*</span></label>																		<!-- Use a dropdown to select property IDs -->
							                <select name="id" class="form-control" onchange="showPropertyDetails()">
							                    <option value="">Select Property ID</option>							                    
							                    <% List<Integer> propertyIds =PropertyDAO.getAllPropertyId(); %>
							                    <% for (Integer propertyId : propertyIds) { %>
							                        <option value="<%= propertyId %>"><%= propertyId %></option>
							                    <% } %>
							                    
               								 </select>
										</div>
									</div>
									<%
									
									%>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>Name</label>
											<input vL name="pname" class="form-control">
										</div>
									</div>
									<input name="username" class="form-control" value="<%= username %>" hidden>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>Mobile Number</label>
											<input name="pmobile" class="form-control">
										</div>
									</div>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
										<label>Status</label>
											<select class="form-control" required name="Status">										
										          <option value="">Select Status</option>
										          <option value="rent">Rent</option>
										          <option value="sale">Sale</option>
											</select>
										</div>
									</div>
									<div class="col-sm-6 col-md-3">
									<label>Type</label>
									<select class="form-control" required name="type">										 
										<option value="">Select Type</option>
										<option value="appartment">Appartment</option>
										<option value="flat">Flat</option>
										<option value="bunglow">Bunglow</option>
										<option value="house">House</option>
										<option value="villa">Villa</option>
										<option value="office">Office</option>
									</select>
								</div>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>AGE</label>
											<input name="age" class="form-control">
										</div>
									</div>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>Dimensions</label>
											<input name="dimensions" class="form-control">
										</div>
									</div>
    								<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>City</label>
											<input name="city" class="form-control">
										</div>
									</div>
									 <div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>Highlights <span class="text-danger">*</span></label>
												<input name="highlights" class="form-control">
										</div>
									</div>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>Amenities <span class="text-danger">*</span></label>											
												<input name="amenities" class="form-control">											
										</div>
									</div>
									<div class="col-sm-6 col-md-3">
										<div class="form-group">
											<label>Price <span class="text-danger">*</span></label>
												<input name="price" class="form-control">	
										</div>
									</div>
									<div class="col-sm-6 col-md-3">
									<div class="form-group">
										<label>Listed_date <span class="text-danger">*</span></label>
										<input class="form-control" name="listeddate" required type="date">
									</div>
									</div>
									<div class="col-sm-6 col-md-3">
											<label>Is_Highlighted <span class="text-danger">*</span></label>
									    <select name="ishighlight" class="form-control">
									        <option value="1">Yes</option>
									        <option value="0">No</option>
									    </select>
									</div>
									<div class="form-group">
					                    <label class="col-form-label">Modification Description <span class="text-danger">*</span></label>
					                    <input name="description"  required class="form-control" type="text">
					                </div>
							<!-- <div class="col-sm-6 col-md-3">
							   	 <div class="form-group">
				                    <label>Highlights</label>
				                    <div class="highlights-container">
				                        Initial highlight item
				                        <div class="highlight-item">
				                            <div class="button-row">
				                                Delete button on the left side
				                                <div class="delete-button" onclick="deleteHighlight(this)">-</div>
				                                Add button on the right side
				                                <div class="add-button" onclick="addHighlight()">+</div>
				                            </div>
				                            <input name="highlights" class="form-control">
				                        </div>
				                    </div>
                                  </div>
							</div> -->
									
								</div>
								<div class="row">
									<div class="col-md-12 col-sm-12">
										<div class="table-responsive">
											
										</div>
										
									</div>
								</div>
								<div class="submit-section">
								<button class="btn btn-danger delete-btn" onclick="deleteProperty()">Delete Property</button>
									<button class="btn btn-primary submit-btn">Save</button>
								</div>
							
						</div>
					</div>
				</div>
				<!-- /Page Content -->
				
			</div>
			<!-- /Page Wrapper -->
			
        </div>
	
		 <script>
		 function deleteProperty() {
			    // Get the selected property ID from the dropdown
			    var selectedPropertyId = $('[name="id"]').find(":selected").val();
			    // Check if a property is selected
			    if (!selectedPropertyId) {
			        // If no property is selected, show an alert
			        alert("Please select a property before clicking the delete button.");
			        return; // Exit the function without proceeding
			    }
			    // Confirm with the user before deleting
			    var confirmDelete = confirm("Are you sure you want to delete this property?");
			    if (confirmDelete) {
			        // Make an AJAX request to the server-side endpoint for deleting the property
			        $.ajax({
			            type: 'POST',
			            url: 'DeletePropertySrv', // Replace with your actual delete property servlet URL
			            data: { propertyId: selectedPropertyId },
			            success: function (data) {
			                // Handle success, e.g., show a success message
			                alert('Property deleted successfully!');
			                // Optionally, you can redirect the user to a different page
			                window.location.href = 'index.jsp'; // Replace with your desired redirect URL
			            },
			            error: function (error) {
			                // Handle error, e.g., show an error message
			                console.error('Error deleting property:', error);
			                alert('Error deleting property. Please try again.');
			            }
			        });
			    }
			}

    function deleteHighlight(button) {
        var highlightItem = button.closest('.highlight-item');
        // Check if it's the only highlight item before removing
        if (document.querySelectorAll('.highlight-item').length > 1) {
            highlightItem.remove();
        }
    }

    function addHighlight() {
        var highlightContainer = document.querySelector('.highlights-container');

        // Create a new highlight item
        var highlightItem = document.createElement('div');
        highlightItem.className = 'highlight-item';

        // Input field for the highlight
        var highlightInput = document.createElement('input');
        highlightInput.name = 'highlights';
        highlightInput.className = 'form-control';
        highlightInput.placeholder = 'Enter Highlight';

        // Input field for the second value
        var secondInput = document.createElement('input');
        secondInput.name = 'secondValues';
        secondInput.className = 'form-control';
        secondInput.placeholder = 'Enter Second Value';

        // Button row
        var buttonRow = document.createElement('div');
        buttonRow.className = 'button-row';

        // Delete button on the left side
        var deleteButton = document.createElement('div');
        deleteButton.className = 'delete-button';
        deleteButton.innerHTML = '-';
        deleteButton.onclick = function () {
            deleteHighlight(this);
        };

        // Add button on the right side
        var addButton = document.createElement('div');
        addButton.className = 'add-button';
        addButton.innerHTML = '+';
        addButton.onclick = addHighlight;

        // Append elements to the button row
        buttonRow.appendChild(deleteButton);
        buttonRow.appendChild(addButton);

        // Append elements to the highlight item
        highlightItem.appendChild(buttonRow);
        highlightItem.appendChild(highlightInput);
        highlightItem.appendChild(secondInput);

        // Append the highlight item to the container
        highlightContainer.appendChild(highlightItem);
    }

    document.querySelector('.submit-btn').onclick = function () {
        var highlightInputs = document.querySelectorAll('.highlight-item input[name="highlights"]');
        var secondInputs = document.querySelectorAll('.highlight-item input[name="secondValues"]');
        var highlightsData = [];

        // Collect data from all highlight and second inputs
        highlightInputs.forEach(function (input, index) {
            var highlightData = {
                highlight: input.value,
                secondValue: secondInputs[index].value,
            };
            highlightsData.push(highlightData);
        });

        // Use AJAX to send data to the server
        // Replace 'your_server_endpoint' with your actual server endpoint
        fetch('your_server_endpoint', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ highlights: highlightsData }),
        })
        .then(response => response.json())
        .then(data => {
            console.log('Data saved successfully:', data);
        })
        .catch(error => {
            console.error('Error saving data:', error);
        });
    };
</script>
<!-- ... Your existing HTML code ... -->

<!-- ... Your existing script and HTML closing tags ... -->

		<!-- Inside your HTML form -->

		<!-- jQuery -->
        <script src="js/jquery-3.2.1.min.js"></script>
		
		<!-- Bootstrap Core JS -->
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
		
		<!-- Slimscroll JS -->
		<script src="js/jquery.slimscroll.min.js"></script>
		
		<!-- Select2 JS -->
		<script src="js/select2.min.js"></script>
		
		<!-- Datetimepicker JS -->	
		<script src="js/moment.min.js"></script>
		<script src="js/bootstrap-datetimepicker.min.js"></script>
		
		<!-- Custom JS -->
		<!--
		<script src="js/app.js"></script>-->
				
        </form>
    </body>
</html>

<%
   }
%>

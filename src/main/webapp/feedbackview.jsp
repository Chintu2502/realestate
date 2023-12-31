<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List" %>
<%@ page import="com.real.bean.AddFeedback" %>
<%@ page import="com.real.serviceimpl.FeedbackDAO" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0">
    <title>LM Homes | Admin</title>

    <!-- Favicon -->
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/favicon.png">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="css/bootstrap.min.css">

    <!-- Fontawesome CSS -->
    <link rel="stylesheet" href="css/font-awesome.min.css">

    <!-- Feathericon CSS -->
    <link rel="stylesheet" href="css/feathericon.min.css">

    <!-- Datatables CSS -->
    <link rel="stylesheet" href="css/dataTables.bootstrap4.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="css/style.css">

</head>

<body> 
    <div class="main-wrapper">
        <!-- Header start -->
        <jsp:include page="header.jsp" />
        <!-- Header end -->

        <!-- Sidebar start -->
        <jsp:include page="sidebar.jsp" />
        <!-- Sidebar end -->

        <!-- Page Content -->
        <div class="page-wrapper">
            <div class="content container-fluid">

                <!-- Page Header -->
                <div class="page-header">
                    <div class="row">
                        <div class="col">
                            <h3 class="page-title">Feedback</h3>
                            <ul class="breadcrumb">
                                <li class="breadcrumb-item"><a href="dashboard.jsp">Dashboard</a></li>
                                <li class="breadcrumb-item active">Feedback View</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- /Page Header -->

                <div class="row">
                    <div class="col-sm-12">
                        <div class="card">
                            <div class="card-header">
                                <table id="basic-datatable" class="table">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>PhoneNumber</th>
                                            <th>Description</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            FeedbackDAO feedbackDao = new FeedbackDAO();
                                            List<AddFeedback> resultSet = feedbackDao.getAllFeedbacks();
                                            for (int i = 0; i < resultSet.size(); i++) {
                                                AddFeedback feedback = resultSet.get(i);
                                        %>
                                        <tr>
                                            <td><%= feedback.getName() %></td>
                                            <td><%= feedback.getPhoneNumber() %></td>
                                            <td><%= feedback.getDescription() %></td>
                                        </tr>
                                        <%
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer start -->
                
                <!-- Footer end -->
            </div>
            <jsp:include page="footer.jsp" />
        </div>
    </div>

    <!-- /Main Wrapper -->

    <!-- jQuery -->
    <script src="js/jquery-3.2.1.min.js"></script>

    <!-- Bootstrap Core JS -->
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.min.js"></script>

    <!-- Datatables JS -->
  
    
    <!-- Custom JS -->
     <!--
    <script src="js/script.js"></script>
	 -->
    <!-- Script for DataTable -->
    <script>
        $(document).ready(function () {
            $('#basic-datatable').DataTable({
                // Add any additional options here
            });
        });
    </script>
</body>
</html>

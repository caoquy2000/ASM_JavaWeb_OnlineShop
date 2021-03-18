<%-- 
    Document   : admin-product-page
    Created on : Mar 3, 2021, 2:10:32 PM
    Author     : caoho
--%>

<%@page import="java.util.Comparator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Collections"%>
<%@page import="quych.dtos.FusionCharts"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="quych.dtos.OrderDTO"%>
<%@page import="java.util.List"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Page</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="./css/style.css">
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link
            href="https://fonts.googleapis.com/css2?family=Roboto:ital,wght@0,100;0,300;0,400;0,500;0,700;0,900;1,100;1,300;1,400;1,500;1,700;1,900&display=swap"
            rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css"
              integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">
        <link rel="stylesheet" href="https://cdn.datatables.net/1.10.23/css/dataTables.bootstrap4.min.css">
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>


        <script type="text/javascript" src="https://cdn.fusioncharts.com/fusioncharts/latest/fusioncharts.js"></script>
        <script type="text/javascript" src="https://cdn.fusioncharts.com/fusioncharts/latest/themes/fusioncharts.theme.fusion.js"></script>
    </head>

    <body>
        <jsp:include page="navbar-admin.jsp" />

        <%

            String username = (String) session.getAttribute("USERNAME");
            List<OrderDTO> dtos = (List<OrderDTO>) request.getAttribute("RESULTSTATICTIS");

            if (username == null) {
                response.sendRedirect("login-page.jsp");
            } else {
                if (!username.equals("admin")) {
                    response.sendRedirect("LoadDataController");
                } else {

                    if (dtos == null) {
                        request.getRequestDispatcher("StatictisController").forward(request, response);
                    }
                }
            }

        %>
        <%            FusionCharts firstChart = null;
            if (dtos != null) {
                Map<String, String> chartConfig = new HashMap<String, String>();
                chartConfig.put("caption", "Order in 7 days");
                chartConfig.put("xAxisName", "Date");
                chartConfig.put("yAxisName", "AmountOfOrder");
                chartConfig.put("numberSuffix", "");
                chartConfig.put("theme", "fusion");
                //store label-value pair
                Map<String, Integer> dataValuePair = new HashMap<String, Integer>();
                for (OrderDTO dto : dtos) {
                    dataValuePair.put(dto.getDayOrder().toString(), dto.getAmountOrder());
                }
                List<Map.Entry<String, Integer>> entries = new ArrayList<Map.Entry<String, Integer>>();
                entries.addAll(dataValuePair.entrySet());
                Collections.sort(entries, new Comparator<Map.Entry<String, Integer>>() {
                    @Override
                    public int compare(Map.Entry<String, Integer> o1, Map.Entry<String, Integer> o2) {
                        return o1.getKey().compareTo(o2.getKey());
                    }
                });

                StringBuilder jsonData = new StringBuilder();
                StringBuilder data = new StringBuilder();
                // json data to use as chart data source
                jsonData.append("{'chart':{");
                for (Map.Entry conf : chartConfig.entrySet()) {
                    jsonData.append("'" + conf.getKey() + "':'" + conf.getValue() + "',");
                }
                jsonData.replace(jsonData.length() - 1, jsonData.length(), "},");
                // build  data object from label-value pair
                data.append("'data':[");
                for (Map.Entry pair : entries) {
                    data.append("{'label':'" + pair.getKey() + "','value':'" + pair.getValue() + "'},");
                }
                data.replace(data.length() - 1, data.length(), "]");
                jsonData.append(data.toString());
                jsonData.append("}");
                // Create chart instance
                // charttype, chartID, width, height,containerid, data format, data
                firstChart = new FusionCharts(
                        "line",
                        "first_chart",
                        "1600",
                        "600",
                        "chart",
                        "json",
                        jsonData.toString()
                );

            }
        %>



        <div class="container--content-admin">
            <jsp:include page="menu-admin.jsp" />
            <div style="width: 100%">
                <div class="search--statictis" style="height: 100px; width: 100%; display: flex; justify-content: center; align-items: center;" >
                    <form action="MainController" method="POST">
                        Xem số lượng đơn hàng từ
                        <input type="date" value="" name="txtDateSearchFr" >
                        đến
                        <input type="date" value="" name="txtDateSearchSe" >
                        <button type="submit" class="btn btn-primary" name="action" value="ViewStatictisFromDateToDate">Xem</button>
                    </form>
                </div>

                <c:if test="${requestScope.RESULTSTATICTIS != null}">
                    <div class="container--chart" style="width: 100%; display: flex; justify-content: center; align-items: center;">
                        <div id =  "chart" > </div>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.RESULTSTATICTIS}">
                    <div id="messageBlock" class="toast fade show" style="margin: 0 auto;">
                        <div class="toast-header">
                            <strong class="mr-auto"><i class="fa fa-globe"></i> Message</strong>
                            <small class="text-muted">Tạm thời</small>
                            <button id="closeMessage" type="button" class="ml-2 mb-1 close" data-dismiss="toast">&times;</button>
                        </div>
                        <div class="toast-body">
                            Không có đơn hàng trong khoảng thời gian này.
                        </div>
                    </div>
                    <script>
                        close = document.getElementById("closeMessage");
                        close.addEventListener('click', function () {
                            message = document.getElementById("messageBlock");
                            message.style.display = 'none';
                        }, false);
                    </script>
                </c:if>
            </div>
        </div>
    </div>
    <script src="./js/index.js"></script>
    <%= firstChart.render()%> 
</body>
</html>
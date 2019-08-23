<#-- @ftlvariable name="" type="com.lyft.data.gateway.resource.GatewayViewResource$GatewayView" -->
<#setting datetime_format = "MM/dd/yyyy hh:mm:ss a '('zzz')'">
<html>
<head>
    <meta charset="UTF-8"/>
    <link rel="stylesheet" type="text/css" href="assets/css/jquery.dataTables.min.css"/>
    <link href="https://fonts.googleapis.com/css?family=Roboto:400,500,700" rel="stylesheet">
    <link href="assets/css/style.css" rel="stylesheet" />

    <script src="assets/js/jquery-3.3.1.js"></script>
    <script src="assets/js/jquery.dataTables.min.js"></script>
    <script src="assets/js/hbar-chart.js"></script>

    <script type="application/javascript">
        $(document).ready(function () {
            $('#queryHistory').DataTable(
                    {
                        "ordering": false,
                        "dom": '<"pull-left"f><"pull-right"l>tip',
                        "width": '100%'
                    }
            );
            $("ul.chart").hBarChart();
        });
    </script>
</head>
<body>
<div class="container">
    <nav class="navbar">
        <div class="container-fluid">
            <div class="navbar-header">
                <table>
                    <tbody>
                        <tr>
                            <td>
                                <a href="/ui/"><img src="assets/img/logo.png"></a>
                            </td>
                            <td>
                                <span class="navbar-brand">Presto Gateway</span>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li>
                <span class="navbar-cluster-info">
                    <span class="uppercase">Started at</span>
                    <br>
                    <span class="text uppercase"><script>document.write(new Date(${gatewayStartTime?long?c}).toLocaleString());</script></span>
                </span>
            </li>
        </ul>
    </nav>
    <div class="group-container">
        <div class="heading-container"><span class="heading">All active backends</span></div>
        <br>
        <table id="availableClusters" class="display">
            <thead>
            <tr>
                <th>Cluster Name</th>
                <th>URL</th>
                <th>Local Port</th>
                <th>Routing Group</th>
            </tr>
            </thead>
            <tbody>
            <#list backendConfigurations as bc>
            <#setting number_format="#####">
            <tr>
                <td>  ${bc.name}</td>
                <td><a href="${bc.proxyTo}" target="_blank">${bc.proxyTo}</a></td>
                <td> ${bc.localPort?string} </td>
                <td> ${bc.routingGroup}</td>
            </tr>
            </#list>
            </tbody>
        </table>
    </div>

    <div class="group-container">
        <div class="heading-container"><span class="heading">All active backends</span></div>
        <br>
        <table id="availableClusters" class="display">
            <thead>
            <tr>
                <th>Cluster Name</th>
                <th>URL</th>
                <th>Local Port</th>
                <th>Routing Group</th>
            </tr>
            </thead>
            <tbody>
            <#list backendConfigurations as bc>
            <#setting number_format="#####">
            <tr>
                <td>  ${bc.name}</td>
                <td><a href="${bc.proxyTo}" target="_blank">${bc.proxyTo}</a></td>
                <td> ${bc.localPort?string} </td>
                <td> ${bc.routingGroup}</td>
            </tr>
            </#list>
            </tbody>
        </table>
    </div>


    <div class="refresh-button-container">
        <a class="button white" onclick="location.reload()" href="">Refresh</a>
    </div>

    <#if queryHistory?size != 0>
    <div class="group-container">
        <div class="heading-container"><span class="heading">Query details [history size = ${queryHistory?size}]</span></div>
        <br>
        <div>
            <table id="queryHistory" class="display" style="width:100%">
                <thead>
                <tr>
                    <th>queryId</th>
                    <th>user</th>
                    <th>source</th>
                    <th>queryText</th>
                    <th>submissionTime</th>
                </tr>
                </thead>
                <tbody class="query-history-table">
                    <#list queryHistory as q>
                    <tr>
                        <td><a href="/ui/query.html?${q.queryId}"
                               target="_blank">${q.queryId}</a></td>
                        <td>  ${q.user}</td>
                        <td>
                            <#if q.source??>
                                ${q.source}
                            </#if>
                        </td>
                        <td>${q.queryText}</td>
                        <td data-order="${q.captureTime}"><script>document.write(new Date(${q.captureTime?long?c}).toLocaleString());</script></td>
                    </tr>
                    </#list>
                </tbody>
            </table>
        </div>
    </div>

    <div class="group-container">
        <div class="heading-container"><span class="heading">Query history distribution</span></div>
        <br>
        <center>
            <ul class="chart">
                <#list queryDistribution?keys as cluster>
                    <li data-data="${queryDistribution[cluster]?string}">
                    ${cluster?string} => ${queryDistribution[cluster]?string}
                    </li>
                </#list>
            </ul>
        <center>
    </div>

    </#if>
 </div>
</body>
</html>
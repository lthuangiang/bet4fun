<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Report</title>
</head>
<body>
<div class="row">
    <div class="col-lg-12">
        <h1 class="page-header">Your Bets</h1>
        <g:if test="${flash.message}">
            <div class="alert alert-success">${flash.message}</div>
        </g:if>
    </div>
</div>
<div class="row">
    <g:each in="${groups}" status="i" var="group">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    ${group.name} - ${group.description}
                </div>
                <!-- /.panel-heading -->
                <div class="panel-body">
                    <div class="table-responsive">
                        <table class="table table-striped table-bordered table-hover" id="dataTables-${group.id}">
                            <thead>
                            <tr>
                                <th>Match</th>
                                <th>Date</th>
                                <th>Rate</th>
                                <th>Result</th>
                                <th>Your Bet</th>
                                <th>You loose!!!</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${bets}" var="bet">
                                <g:if test="${bet.match.group.id = group.id}">
                                    <tr>
                                        <td>
                                            <span>
                                                ${bet.match.home.name}
                                                <span class="flag-icon flag-icon-${bet.match.home.isoCode2}"></span>   VS   <span class="flag-icon flag-icon-${bet.match.guess.isoCode2}"></span>
                                                ${bet.match.guess.name}
                                            </span>
                                        </td>
                                        <td><g:formatDate format="yyyy-MM-dd HH:mm" date="${bet.match.date}"/></td>
                                        <td>
                                            <g:formatNumber number="${bet.match.hRate}" format="#.##"/>
                                            :<g:formatNumber number="${bet.match.gRate}" format="#.##"/>
                                        </td>
                                        <td>${bet.match.hScore}:${bet.match.gScore}</td>
                                        <td>
                                            <g:if test="${bet.choose == 1}">${bet.match.home.name}</g:if>
                                            <g:if test="${bet.choose == -1}">${bet.match.guess.name}</g:if>
                                            <g:if test="${bet.choose == 0}">N/A</g:if>
                                        </td>
                                        <td>${bet.amount}</td>
                                    </tr>
                                </g:if>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
                <!-- /.panel-body -->
            </div>
            <!-- /.panel -->
        </div>
        <!-- /.col-lg-12 -->
    </g:each>
</div>
<script>
    $(document).ready(function() {
        <g:each in="${groups}" status="i" var="group">
        $('#dataTables-${group.id}').dataTable({
            "order": [[ 1, "desc" ]]
        });
        </g:each>
    });
</script>
</body>
</html>
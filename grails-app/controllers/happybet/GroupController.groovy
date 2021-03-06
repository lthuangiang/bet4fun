package happybet

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_GROUP'])
class GroupController {

    def betService

    def index() {
        render view: 'index', model: [groups: BetGroup.findAllByOwner(request.getRemoteUser())]
    }

    def matches () {
        def match = new BetMatch(params)
        if (params.matchId) {
            match = BetMatch.findById(params.matchId)
        }

        render view: 'matches', model: [groupId: params.groupId, matchId: params.matchId,
                                       betMatchInstance: match, teams: Team.list()]
    }

    def save() {
        if (params.matchId)
            betService.updateMatch(params.matchId, params.home, params.guess, params.date, Integer.valueOf(params.hScore),
                    Integer.valueOf(params.gScore), Float.valueOf(params.hRate), Float.valueOf(params.gRate),
                    Double.valueOf(params.amount))
        else
            betService.createMatch(params.group, params.home, params.guess, params.date, Integer.valueOf(params.hScore),
                    Integer.valueOf(params.gScore), Float.valueOf(params.hRate), Float.valueOf(params.gRate),
                    Double.valueOf(params.amount))
        redirect(controller: 'group')
    }

    def remove() {
        betService.deleteMatch(params.groupId, params.matchId)
        index()
    }

    def member() {
        render view: 'member', model: [groupId: params.groupId]
    }

    def addUser() {
        def errMsg = betService.addUserToGroup(params.group, params.email)
        if (errMsg) {
            flash.error = errMsg
        } else {
            flash.message = 'Added ' + params.email + ' to group successfully.'
        }
        member()
    }

    def delUser() {
        betService.removeUserFromGroup(params.groupId, params.userId)
        index()
    }

    def sysSchedules() {
        def schedules = SystemSchedule.findAllByEndDateGreaterThan(new Date())
        render view: 'sysSchedules', model: [schedules: schedules]
    }

    def importMatches() {
        def groups = BetGroup.findAllByOwner(request.getRemoteUser())
        groups.each { group ->
            betService.importMatches(params.id, group)
        }
        index()
    }
}

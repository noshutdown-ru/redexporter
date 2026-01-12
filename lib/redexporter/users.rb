require "prometheus_exporter/metric"

module RedExporter::Users
  def self.users_metrics()
    result = "# HELP redmine_users Total users by status, role, and group\n"
    result += "# TYPE redmine_users gauge\n"

    begin
      # Get all users
      users = User.where("type = ?", 'User').all

      # Group by status, role, group
      user_groups = {}

      users.each do |user|
        # Determine status
        status = case user.status
                 when User::STATUS_ACTIVE
                   'active'
                 when User::STATUS_REGISTERED
                   'registered'
                 when User::STATUS_LOCKED
                   'locked'
                 else
                   'unknown'
                 end

        # Check if inactive (no login in 30 days)
        if user.last_login_on && user.last_login_on < 30.days.ago
          status = 'inactive'
        end

        # Get roles
        roles = user.roles.pluck(:name)
        role_str = roles.any? ? roles.join(',') : 'no_role'

        # Get groups
        groups = user.groups.pluck(:name)
        group_str = groups.any? ? groups.join(',') : 'no_group'

        # Create key for grouping
        key = {
          status: status,
          role: role_str,
          group: group_str
        }

        user_groups[key] ||= 0
        user_groups[key] += 1
      end

      # Generate metric output
      user_groups.each do |labels, count|
        label_str = "status=\"#{labels[:status]}\",role=\"#{labels[:role]}\",group=\"#{labels[:group]}\""
        result += "redmine_users{#{label_str}} #{count}\n"
      end

      # Add total users metric
      result += "redmine_users_total #{users.count}\n"
    rescue
      result += "redmine_users 0\n"
    end

    result
  end
end

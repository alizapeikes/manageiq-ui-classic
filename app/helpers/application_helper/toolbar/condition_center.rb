class ApplicationHelper::Toolbar::ConditionCenter < ApplicationHelper::Toolbar::Basic
  button_group('condition_vmdb', [
    select(
      :condition_vmdb_choice,
      nil,
      t = N_('Configuration'),
      t,
      :items => [
        button(
          :condition_edit,
          'pficon pficon-edit fa-lg',
          t = N_('Edit this Condition'),
          t,
          :url_parms => "?type=basic",
          :klass     => ApplicationHelper::Button::ReadOnly),
        button(
          :condition_copy,
          'fa fa-files-o fa-lg',
          t = N_('Copy this Condition to a new Condition'),
          t,
          :url_parms => "?copy=true",
          :klass     => ApplicationHelper::Button::Condition),
        button(
          :condition_policy_copy,
          'fa fa-files-o fa-lg',
          t = proc do
            _('Copy this Condition to a new Condition assigned to Policy [%{condition_policy_description}]') %
              {:condition_policy_description => @condition_policy.try(:description)}
          end,
          t,
          :url_parms => "?copy=true",
          :klass     => ApplicationHelper::Button::ConditionPolicyCopy),
        button(
          :condition_delete,
          'pficon pficon-delete fa-lg',
          t = proc do
            _('Delete this %{condition_type} Condition') % {:condition_type => ui_lookup(:model => @condition.towhat)}
          end,
          t,
          :klass => ApplicationHelper::Button::ConditionDelete,
          :data  => {'function'      => 'sendDataWithRx',
                     'function-data' => {:api_url        => 'conditions',
                                         :component_name => 'RemoveGenericItemModal',
                                         :controller     => 'provider_dialogs',
                                         :display_field  => 'description',
                                         :tree_select    => 'root'}}),
        button(
          :condition_remove,
          'pficon pficon-delete fa-lg',
          t = proc do
            _('Remove this Condition from Policy [%{condition_policy_description}]') %
            {:condition_policy_description => @condition_policy.try(:description)}
          end,
          t,
          :url_parms => "?policy_id=\#{@condition_policy.try(:id)}",
          :klass     => ApplicationHelper::Button::ConditionPolicy,
          :confirm   => proc do
                          _("Are you sure you want to remove this Condition from Policy [%{condition_policy_description}]?") %
                          {:condition_policy_description => @condition_policy.try(:description)}
                        end
        ),
      ]),
    ])
end

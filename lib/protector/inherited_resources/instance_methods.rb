module Protector::InheritedResources
  module InstanceMethods
    extend ActiveSupport::Concern

    def end_of_association_chain
      resource = super

      subject = self.class.effective_protector_subject

      if subject.kind_of? Symbol
        subject = send subject
      elsif subject
        subject = instance_exec &subject
      end

      if subject != false && resource.respond_to?(:restrict!)
        resource.restrict! subject
      else
        resource
      end
    end
  end
end

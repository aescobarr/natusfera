module Shared::TouchesObservationModule
  def self.included(base)
    # base.extend ClassMethods
    base.after_create  :touch_observation
    base.after_destroy :touch_observation
  end

  def touch_observation
    observation.touch if observation
    true
  end
end

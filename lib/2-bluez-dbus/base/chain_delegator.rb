# frozen_string_literal: true

# For clients of chains of responsibility
# Add API for adding chain, and target send to own chain
module ChainDelegator
  attr_reader :head_of_state

  def shirk(signal)
    raise(FuckingAnarchy, 'no head of state!') unless head_of_state
    head_of_state.handle(signal)
  end

  # add head of estabished chain (instances with successors set)
  def long_live(the_queen)
    raise(NaughtyHandler, 'not nepotistic?') unless the_queen.respond_to?(:handle)
    @head_of_state = the_queen
  end

  # allows clients to give a list of klasses without setting up the liniage
  def succession(lineage); end
end

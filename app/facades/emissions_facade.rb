class EmissionsFacade
  def initialize(search=nil)
    @search = search
  end

  def total_emissions
    service = EmissionsService.new(@search)
    details = service.emissions_request
    @emissions_saved = Emission.new(details)
  end
end
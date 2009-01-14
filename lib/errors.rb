module Kivi
  class Error; end
  class MethodNameError         < Kivi::Error; end
  class ModelNameError          < Kivi::Error; end
  class NoApplicationError      < Kivi::ModelNameError; end
  class ModelIDError            < Kivi::Error; end
  class UnhandledRequestError   < Kivi::Error; end
end
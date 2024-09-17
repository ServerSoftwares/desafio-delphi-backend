namespace AnexarApi.Utils
{
    public class Response
    {
        public string? Id { get; set; }
        public string? Message { get; set; }
        public object? Data { get; set; }



        public Response() { }

        public Response(string xId, string xMessage)
        {
            Id = xId;
            Message = xMessage;
        }

        public Response(string xId, object? xData)
        {
            Id = xId;
            Data = xData;
        }

        public Response(string xId, string xMessage, object? xData)
        {
            Id = xId;
            Message = xMessage;
            Data = xData;
        }
    }
}
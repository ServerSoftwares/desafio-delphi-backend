using AnexarApi.Utils;
using api_desafio_delphi.DAO;
using api_desafio_delphi.Models;
using Microsoft.AspNetCore.Mvc;

namespace api_desafio_delphi.Controllers
{
    [ApiController]
    [Route("api/cep")]
    public class CEPController : Controller
    {
        // GET: api/cep/consultar?cep=94060-000
        [HttpGet]
        [Route("consultar")]
        public IActionResult Consultar(string cep)
        {
            try
            {
                TCEP? obj = new CEPDAO().CarregarPorCEP(cep);
                if (obj != null)
                    return Ok(new Response(obj.CEP, "CEP encontrado", obj));
                else
                    throw new Exception("CEP n�o encontrado");
            }
            catch (Exception ex)
            {
                return BadRequest(new Response("Erro", ex.Message));
            }
        }
    }
}

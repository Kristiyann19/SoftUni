using System;
using System.Data.SqlClient;
using System.Text;

namespace Ado.Net
{
    internal class Program
    {
        static void Main(string[] args)
        {
            SqlConnection conn = new SqlConnection(@"Server=DESKTOP-VM1OT4C;Database=MinionsDB;Trusted_Connection=True;");

            conn.Open();

            SqlCommand cmd = new SqlCommand(@"SELECT v.Name, COUNT(mv.VillainId) AS MinionsCount  
                                                  FROM Villains AS v
                                                  JOIN MinionsVillains AS mv ON v.Id = mv.VillainId
                                              GROUP BY v.Id, v.Name
                                                HAVING COUNT(mv.VillainId) > 3
                                              ORDER BY COUNT(mv.VillainId)", conn);

            SqlDataReader reader = cmd.ExecuteReader();

            using (reader)
            {
                StringBuilder sb = new StringBuilder();

                while (reader.Read())
                {
                    string villainName = reader["Name"].ToString();
                    string countOfMinions = reader["MinionsCount"].ToString();
                    sb.AppendLine($"{villainName} - {countOfMinions}");
                }

                Console.WriteLine(sb.ToString().TrimEnd());

            }
        }
    }
}

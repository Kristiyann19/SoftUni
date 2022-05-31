using System;

namespace MiniORM
{
	internal class DbContext
    {
        public static Type[] AllowedSqlTypes = {typeof(int), typeof(string)};
    }
}
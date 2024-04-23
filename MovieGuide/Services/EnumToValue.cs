using MovieGuide.Enums;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MovieGuide.Services
{
    public static class EnumToValue
    {
        public static int ConvertGenreToId(Genre genre)
        {
            switch (genre)
            {
                case Genre.Action:
                    return 0;
                case Genre.Adventure:
                    return 1;
                case Genre.Comedy:
                    return 2;
                case Genre.Drama:
                    return 3;
                case Genre.Fantasy:
                    return 4;
                case Genre.Horror:
                    return 5;
                case Genre.Mystery:
                    return 6;
                case Genre.Romance:
                    return 7;
                case Genre.SciFi:
                    return 8;
                case Genre.Thriller:
                    return 9;
                case Genre.Western:
                    return 10;
                default:
                    throw new ArgumentException("Unknown genre", nameof(genre));
            }
        }
    }
}

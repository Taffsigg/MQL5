//+------------------------------------------------------------------+
//|                                             test_InfoSession.mq5 |
//|                        Copyright 2015, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2015, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
  {
//--- a matriz onde os dias da semana s�o armazenados
   ENUM_DAY_OF_WEEK days[]={SUNDAY,MONDAY,TUESDAY,WEDNESDAY,THURSDAY,FRIDAY,SATURDAY};
   int size=ArraySize(days);

//---
   Print("Sess�es de cota��o "+Symbol());
//--- verificar todas as sess�es deste dia
   for(int d=0;d<size;d++)
     {
      PrintInfoForQuoteSessions(Symbol(),days[d]);
     }

//---
   Print("Sess�es de negocia��o");
//--- verificar todas as sess�es deste dia

   for(int d=0;d<size;d++)
     {
      PrintInfoForTradeSessions(Symbol(),days[d]);
     }   

  }
  
  
  void PrintInfoForQuoteSessions(string symbol,ENUM_DAY_OF_WEEK day)
  {
//--- in�cio e fim de sess�o
   datetime start,finish;
   uint session_index=0;
   bool session_exist=true;

//--- verificar todas as sess�es deste dia
   while(session_exist)
     {
      //--- verificar se h� uma sess�o de cota��o com o n�mero session_index
      session_exist = SymbolInfoSessionQuote(symbol, day, session_index, start, finish);
      
      start = SymbolInfoInteger(symbol, SYMBOL_START_TIME );
      finish = SymbolInfoInteger(symbol, SYMBOL_EXPIRATION_TIME );

      //--- se existe tal sess�o
      if(session_exist)
        {
         //--- mostrar o dia da semana, o n�mero da sess�o e o tempo de in�cio e fim
         Print(DayToString(day), ": session_indexo=", session_index, "  come�o=",
               TimeToString(start,TIME_MINUTES), "    final=", TimeToString(finish-1,TIME_MINUTES|TIME_SECONDS));
        }
      //--- aumentar o contador de sess�es
      session_index++;
     }
  }

  void PrintInfoForTradeSessions(string symbol,ENUM_DAY_OF_WEEK day)
  {
//--- in�cio e fim de sess�o
   datetime start,finish;
   uint session_index=0;
   bool session_exist=true;

//--- verificar todas as sess�es deste dia
   while(session_exist)
     {
      //--- verificar se h� uma sess�o de cota��o com o n�mero session_index
      session_exist = SymbolInfoSessionTrade(symbol, day, session_index, start, finish);

      //--- se existe tal sess�o
      if(session_exist)
        {
         //--- mostrar o dia da semana, o n�mero da sess�o e o tempo de in�cio e fim
         Print(DayToString(day), ": session_index=", session_index, "  come�o=",
               TimeToString(start,TIME_MINUTES), "    final=", TimeToString(finish-1,TIME_MINUTES|TIME_SECONDS));
        }
      //--- aumentar o contador de sess�es
      session_index++;
     }
  }
  string DayToString(ENUM_DAY_OF_WEEK day)
  {
   switch(day)
     {
      case SUNDAY:    return "Domingo";
      case MONDAY:    return "Segunda";
      case TUESDAY:   return "Ter�a";
      case WEDNESDAY: return "Quarta";
      case THURSDAY:  return "Quinta";
      case FRIDAY:    return "Sexta";
      case SATURDAY:  return "S�bado";
      default:        return "Dia da semana n�o definido";
     }
   return "";
  }
  
  

//+------------------------------------------------------------------+

Class KWAS.Patient.Functions Extends Ens.Rule.FunctionSet
{

ClassMethod ExtractUN(Numbers) As %String
{
	Set UN=..FindUN(Numbers)
	
	If UN'="" {
		Set UN="RFS"_UN_"^^^^UID"
	}
	
	Quit UN
}

ClassMethod NACS() As %String
{
	Quit "RFS"
}

ClassMethod FindUN(Numbers) As %String
{
	Set UN=""
	
	For i = 1:1:$Length(Numbers,"~") {
		Set Number=$Translate($Piece($Piece(Numbers,"~",i),"^")," ")
		
		If $extract(Number,1) = "G" {
			Set UN = Number
			Quit
		}
	}
	
	Quit UN
}

ClassMethod FindNHS(Numbers) As %String
{
	Set NHS=""
	
	For i = 1:1:$Length(Numbers,"~") {
		Set Number=$TR($Piece($Piece(Numbers,"~",i),"^")," ")
		
		If Number?10N {
			Set NHS=Number
			
			Quit
		}
	}
	
	Quit NHS
}

ClassMethod ExtractNHS(Numbers) As %String
{
	Set NHS=..FindNHS(Numbers)
	
	If NHS'="" {
		Set NHS=NHS_"^^^^UID~"_NHS_"^^^^NHS"
	}
	
	Quit NHS
}

ClassMethod GetNumber(Numbers) As %String
{
	Set NHS=..ExtractNHS(Numbers)
	
	If NHS'="" Quit NHS

	Quit ..ExtractUN(Numbers)
}

ClassMethod NNTS(Numbers) As %String
{
	Set NNTS=""
	
	For i = 1:1:$Length(Numbers,"~") {
		Set Number=$Piece($Piece(Numbers,"~",i),"^")
		
		If Number?10N {
			Set NNTS=$Piece(Number,"^",2)
		}
	}
	
	If NNTS="" {
		Quit "03"
	} Else {
		Quit $Case(NNTS,
				10:"02",
				11:"03",
				12:"06",
				13:"07",
				14:"08",
				15:"02",
				16:"03",
				17:"07",
				20:"01",
				21:"04",
				22:"04",
				30:"01",
				31:"05",
				32:"05",
				33:"05",
				34:"05",
				35:"05",
				36:"05",
				40:"05",
				41:"05",
				42:"05",
			
				:"03")
	}
}

ClassMethod GetPID(numbers As %String) As %String
{
	Set NHS=..FindNHS(numbers)
	Set INUM=..FindUN(numbers)

	If NHS'="" {
		Set CheckNumber = NHS
	} Else {
		If INUM'="" {
			Set CheckNumber = INUM
		} Else {
			Quit ""
		}
	}
	
	Quit CheckNumber
}

}

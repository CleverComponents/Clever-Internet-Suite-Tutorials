object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 543
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 344
    Top = 232
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 553
    Height = 209
    Lines.Strings = (
      
        '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap' +
        '/envelope/" '
      
        'xmlns:typ="http://htng.org/PWS/2008B/SingleGuestItinerary/Reserv' +
        'ation/Types" '
      
        'xmlns:typ1="http://htng.org/PWS/2008B/SingleGuestItinerary/Commo' +
        'n/Types">'
      ' <soapenv:Header/>'
      ' <soapenv:Body>'
      ' <typ:ReservationLookupResponse>'
      ' <Result resultStatusFlag="SUCCESS" code="cum murmure">'
      ' <!--Optional:-->'
      ' <typ1:Text>'
      ' <!--1 or more repetitions:-->'
      
        ' <typ1:TextElement language="language">ventos tempestatesque</ty' +
        'p1:TextElement>'
      ' </typ1:Text>'
      ' <!--Optional:-->'
      ' <typ1:IDs>'
      ' <!--Zero or more repetitions:-->'
      
        ' <typ1:UniqueID source="temperat iras">turbine corripuit</typ1:U' +
        'niqueID>'
      ' </typ1:IDs>'
      ' </Result>'
      ' <!--Optional:-->'
      ' <ReservationLookups>'
      ' <!--Zero or more repetitions:-->'
      ' <ReservationLookup reservationStatus="CHECKED_IN" '
      'otherReservationStatus="otherReservationStatus">'
      ' <!--Optional:-->'
      ' <ReservationID source="OPERA">1620979</ReservationID>'
      ' <!--Optional:-->'
      ' <ProfileID source="2254583">2254583</ProfileID>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <RoomNumber>10</RoomNumber>'
      ' <!--Optional:-->'
      ' <DateRange>'
      ' <!--type: dateTime-->'
      ' <typ1:Start>2006-11-02T00:00:00-06:00</typ1:Start>'
      ' <!--Optional:-->'
      ' <!--type: dateTime-->'
      ' <typ1:End>2006-11-05T00:00:00-05:00</typ1:End>'
      ' </DateRange>'
      ' <!--Optional:-->'
      
        ' <ProfileInfo nameOrdered="NameOrdered" familiarName="FamiliarNa' +
        'me">'
      ' <!--Zero or more repetitions:-->'
      ' <!--type: string-->'
      ' <typ1:NameTitle>NameTitle</typ1:NameTitle>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:FirstName>Vernon</typ1:FirstName>'
      ' <!--Zero or more repetitions:-->'
      ' <!--type: string-->'
      ' <typ1:MiddleName>S</typ1:MiddleName>'
      ' <!--type: string-->'
      ' <typ1:LastName>Smith</typ1:LastName>'
      ' <!--Zero or more repetitions:-->'
      ' <!--type: string-->'
      ' <typ1:NameSuffix>NameSuffix</typ1:NameSuffix>'
      ' </ProfileInfo>'
      ' <!--Optional:-->'
      
        ' <ReservationAddress addressType="" otherAddressType="1234 Aliga' +
        'tor way">'
      ' <!--0 to 5 repetitions:-->'
      ' <!--type: string-->'
      ' <typ1:AddressLine>1234 Aligator way</typ1:AddressLine>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:CityName>Vanderbilt Beach</typ1:CityName>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:StateProv>FL</typ1:StateProv>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:CountryCode>US</typ1:CountryCode>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:PostalCode>34107</typ1:PostalCode>'
      ' </ReservationAddress>'
      ' <!--Optional:-->'
      ' <MembershipID>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:MembershipType>volutans nimborum in</typ1:MembershipType>'
      ' <!--type: string-->'
      ' <typ1:MembershipNumber>faciat maria</typ1:MembershipNumber>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:MembershipLevel>et quisquam</typ1:MembershipLevel>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <typ1:MemberName>MemberName</typ1:MemberName>'
      ' <!--Optional:-->'
      ' <!--type: date-->'
      ' <typ1:EffectiveDate>2014-12-08</typ1:EffectiveDate>'
      ' <!--Optional:-->'
      ' <!--type: date-->'
      ' <typ1:ExpirationDate>2019-03-02</typ1:ExpirationDate>'
      ' <!--Optional:-->'
      ' <!--type: long-->'
      ' <typ1:CurrentPoints>10</typ1:CurrentPoints>'
      ' </MembershipID>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <ConfirmationNo>ConfirmationNo</ConfirmationNo>'
      ' <!--Optional:-->'
      ' <!--type: string-->'
      ' <ResortId>ResortID</ResortId>'
      ' <!--Optional:-->'
      ' <PhoneList>'
      ' <!--Zero or more repetitions:-->'
      ' <typ1:Phone phoneType="PhoneType" phoneRole="PhoneRold">'
      ' <!--You have a CHOICE of the next 2 items at this level-->'
      ' <!--type: string-->'
      ' <typ1:PhoneNumber>PhoneNumber</typ1:PhoneNumber>'
      ' <typ1:PhoneData>'
      ' <!--type: string-->'
      
        ' <typ1:CountryAccessCode>CountryAccessCode</typ1:CountryAccessCo' +
        'de>'
      ' <!--type: string-->'
      ' <typ1:AreaCode>AreaCode</typ1:AreaCode>'
      ' <!--type: string-->'
      ' <typ1:PhoneNumber>PhoneNumber</typ1:PhoneNumber>'
      ' <!--type: string-->'
      ' <typ1:Extension>PhoneExtension</typ1:Extension>'
      ' </typ1:PhoneData>'
      ' </typ1:Phone>'
      ' </PhoneList>'
      ' </ReservationLookup>'
      ' </ReservationLookups>'
      ' </typ:ReservationLookupResponse>'
      ' </soapenv:Body>'
      '</soapenv:Envelope>')
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Memo2: TMemo
    Left = 0
    Top = 280
    Width = 553
    Height = 265
    Lines.Strings = (
      'Memo2')
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object clHtmlParser1: TclHtmlParser
    ParseMethod = pmAll
    Left = 104
    Top = 232
  end
end

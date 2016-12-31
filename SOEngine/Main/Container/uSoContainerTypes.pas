unit uSoContainerTypes;

interface

uses
  uSoObject, uSoBasePart;

type

  TContainerElementDescription = record
    Name: string;
    TemplateName: string;
    constructor Create(AName, ATemplateName: string);
  end;

  TDoubleParameteredDelegate<TClassTemplate, T> =
    function(AClass: TClassTemplate; AName: T): TObject of object;

  TAddContainerElementDelegate = TDoubleParameteredDelegate<TClass, TContainerElementDescription>;
  TGetContainerElementDelegate = TDoubleParameteredDelegate<TClass, string>;

  TOnAddContainerEventArgs = record
    Subject: TSoObject;
    BasePart: TSoBasePart;
    constructor Create(const ASubject: TSoObject; ABasePart: TSoBasePart);
  end;

implementation

{ TOnAddContainerEventArgs }

constructor TOnAddContainerEventArgs.Create(const ASubject: TSoObject; ABasePart: TSoBasePart);
begin
  Subject := ASubject;
  BasePart := ABasePart;
end;

{ TContainerElementDescription }

constructor TContainerElementDescription.Create(AName, ATemplateName: string);
begin
  Name := AName;
  TemplateName := ATemplateName;
end;

end.
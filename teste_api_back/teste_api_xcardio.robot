*** Settings ***
Library    RequestsLibrary
Test Setup    Create Session    alias=api_xcardio    url=http://127.0.0.1:8000/api    headers=${header}

*** Variables ***
&{header}    Content-Type=application/json    XCARDIO-API-KEY=658f2bb5-101a-47b0-b0d7-0e5d23212da1

${classificando_amostra_por_framingham}
    ...         data=2024-03-22
    ...         pessoa=11726_b63dda65-4e8a-4721-b554-64cb0984d34f
    ...         sex=FEMININO
    ...         person_age_years=34
    ...         PRESSAO_ARTERIAL_PAS=120.0
    ...         COLESTEROL_TOTAL=60.0
    ...         HDL=60.0
    ...         IMC=27.34
    ...         smoking=${false}
    ...         regular_use_of_medication=${true}
    ...         has_family_diabetes_mellitus_history=${false}

*** Keywords ***

*** Test Cases ***
# AMOSTRAGEM PARA ROTULAÇÃO
# GET verificando amostras rotuladas
# GET lendo amostra para rotulagem
# POST salvar amostras rotuladas
# GET criando ou atualizando amostras

# DATASET
#POST atualizar dataset
GET enviando ultima data dos dados
    ${RETORNO}    GET On Session    alias=api_xcardio    url=/enviando_ultima_data_dos_dados/
    
    # status do retorno
    Log To Console    ${RETORNO}
    # texto do retorno    
    Log To Console    ${RETORNO.text}

# CLASSIFICAR POR CALCULADORA
POST amostras por Framingham
    Log    ${classificando_amostra_por_framingham}

    # Serializando os dados corretamente para JSON
    ${body}    Evaluate    json.dumps(${classificando_amostra_por_framingham})

    ${RETORNO}    POST On Session    alias=api_xcardio    url=/classificando_amostra_por_framingham    data=${body}
    
    # status do retorno
    Log To Console    ${RETORNO}
    # texto do retorno    
    Log To Console    ${RETORNO.json()}


# CLASSIFICAR POR ML


# SCORES

#TREINANDO CLASSIFICADOR

# XAI_CONFIG

# XAI_CLASSIFICATION

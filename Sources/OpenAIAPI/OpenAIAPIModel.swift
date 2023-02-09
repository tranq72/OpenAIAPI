//
//  OpenAIAPIModel.swift
//
//  Created by Nico Tranquilli on 05/02/23.
//

import Foundation

public enum OpenAIAPIModel {
    case text_davinci_003
    case text_davinci_002
    case text_davinci_001
    
    case text_curie_001
    case text_babbage_001
    case text_ada_001
    
    case text_davinci_edit_001
    case text_davinci_insert_002
    case text_davinci_insert_001
    
    case code_davinci_002
    case code_cushman_001
    
    case code_davinci_edit_001
    
    case text_search_babbage_doc_001
    case text_search_curie_doc_001
    case text_search_curie_query_001
    case text_search_davinci_doc_001
    case text_search_babbage_query_001
    case text_search_ada_query_001
    case text_search_ada_doc_001
    case text_search_davinci_query_001
    
    case text_similarity_davinci_001
    case text_similarity_curie_001
    case text_similarity_ada_001
    case text_similarity_babbage_001
    
    case text_embedding_ada_002
    
    case babbage
    case ada
    case davinci
    case curie
    
    case davinci_similarity
    case babbage_similarity
    case ada_similarity
    case curie_similarity
    
    case babbage_code_search_text
    case ada_code_search_text
    
    case babbage_code_search_code
    case ada_code_search_code
    
    case curie_search_query
    case babbage_search_query
    case davinci_search_query
    case ada_search_query
    
    case code_search_babbage_text_001
    case code_search_ada_text_001
    
    case code_search_babbage_code_001
    case code_search_ada_code_001
    
    case davinci_search_document
    case curie_search_document
    case babbage_search_document
    case ada_search_document
    
    case davinci_instruct_beta
    case curie_instruct_beta
    
    public var name: String {
        return String(describing: self).replacingOccurrences(of: "_", with: "-")
    }
}
